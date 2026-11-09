*** Settings ***
Documentation     Keyword bersama untuk semua suite: buka/tutup browser, klik,
...               tunggu navigasi, dan screenshot saat gagal.
Library           SeleniumLibrary    run_on_failure=No Operation
Variables         ../variables/env.py
Resource          ../variables/testdata.resource
Resource          pages/login_page.resource
Resource          pages/inventory_page.resource
Resource          pages/cart_page.resource
Resource          pages/checkout_page.resource

*** Keywords ***
Open Test Browser
    [Documentation]    Membuka browser baru untuk setiap test supaya test saling
    ...                independen. Set HEADLESS=false untuk melihat browsernya.
    ${options}=    Set Variable    add_argument("--window-size=1440,900");add_argument("--disable-dev-shm-usage")
    IF    ${HEADLESS}
        ${options}=    Set Variable    ${options};add_argument("--headless=new")
    END
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}

Close Test Browser
    Run Keyword If Test Failed    Capture Page Screenshot    ${OUTPUT DIR}/FAILED-${TEST NAME}.png
    Close All Browsers

Click Test Id
    [Documentation]    Klik elemen berdasarkan atribut data-test lewat DOM.
    ...                Chrome headless di environment ini tidak selalu
    ...                meneruskan klik pointer ke handler React, sedangkan klik
    ...                DOM memanggil handler yang sama.
    [Arguments]    ${test_id}
    ${script}=    Catenate    SEPARATOR=
    ...    var el = document.querySelector('[data-test="${test_id}"]');
    ...    if (!el) { throw new Error('Elemen tidak ditemukan: ${test_id}'); }
    ...    el.click();
    Execute JavaScript    ${script}

Click And Wait For Location
    [Documentation]    Klik lalu tunggu URL berubah. Klik diulang sampai 15 detik
    ...                kalau navigasi belum terjadi.
    [Arguments]    ${test_id}    ${url_part}
    Wait Until Keyword Succeeds    15s    500ms    Click Test Id And Check Location    ${test_id}    ${url_part}

Click Test Id And Check Location
    [Arguments]    ${test_id}    ${url_part}
    Click Test Id    ${test_id}
    Wait Until Location Contains    ${url_part}    2s

Wait Until Page Is Ready
    [Documentation]    Menunggu DOM dan semua gambar selesai dimuat supaya klik
    ...                tidak bergeser karena layout berubah.
    Wait Until Keyword Succeeds    15s    200ms    Page Is Fully Loaded

Page Is Fully Loaded
    ${ready}=    Execute JavaScript    return document.readyState
    Should Be Equal    ${ready}    complete
    ${pending}=    Execute JavaScript    return Array.from(document.images).filter(function(i){return !i.complete;}).length
    Should Be Equal As Integers    ${pending}    0

Click Product Button
    [Documentation]    Klik tombol add/remove di dalam kartu produk lewat DOM.
    [Arguments]    ${product_name}    ${action}
    ${script}=    Catenate    SEPARATOR=
    ...    var card = Array.from(document.querySelectorAll('[data-test="inventory-item"]')).find(function(c){var n=c.querySelector('[data-test="inventory-item-name"]'); return n && n.textContent.trim() === "${product_name}";});
    ...    if (!card) { throw new Error('Produk tidak ditemukan: ${product_name}'); }
    ...    card.querySelector('button[data-test^="${action}"]').click();
    Execute JavaScript    ${script}

