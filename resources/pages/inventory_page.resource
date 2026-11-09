*** Settings ***
Documentation     Page object halaman katalog produk.
Library           SeleniumLibrary

*** Variables ***
${INVENTORY_LIST}      css:[data-test="inventory-list"]
${INVENTORY_ITEM}      css:[data-test="inventory-item"]
${SORT_DROPDOWN}       css:[data-test="product-sort-container"]
${CART_BADGE}          css:[data-test="shopping-cart-badge"]
${CART_LINK}           css:[data-test="shopping-cart-link"]

*** Keywords ***
Verify Inventory Page Is Displayed
    Wait Until Element Is Visible    ${INVENTORY_LIST}    ${DEFAULT_TIMEOUT}
    Wait Until Page Is Ready

Verify Product Count
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    ${INVENTORY_ITEM}
    Should Be Equal As Integers    ${count}    ${expected_count}

Sort Products By
    [Arguments]    ${option}
    [Documentation]    Opsi yang dipakai: az, za, lohi, hilo.
    Select From List By Value    ${SORT_DROPDOWN}    ${option}

First Product Name Should Be
    [Arguments]    ${expected_name}
    ${name}=    Get Text    xpath:(//div[@data-test="inventory-item-name"])[1]
    Should Be Equal    ${name}    ${expected_name}

Get First Product Name
    ${name}=    Get Text    xpath:(//div[@data-test="inventory-item-name"])[1]
    RETURN    ${name}

Get First Product Price
    ${price}=    Get Text    xpath:(//div[@data-test="inventory-item-price"])[1]
    RETURN    ${price}

Add Product To Cart
    [Documentation]    Klik tombol tambah dan tunggu tombol berubah menjadi Remove.
    ...                Kalau klik terjadi sebelum React siap, klik diulang.
    [Arguments]    ${product_name}
    ${card}=    Product Card Locator    ${product_name}
    Wait Until Keyword Succeeds    15s    500ms    Click Add And Wait For Remove    ${product_name}    ${card}

Click Add And Wait For Remove
    [Arguments]    ${product_name}    ${card}
    Click Product Button    ${product_name}    add-to-cart
    Wait Until Element Is Visible    ${card}//button[contains(@data-test,"remove")]    2s

Remove Product From Cart
    [Arguments]    ${product_name}
    ${card}=    Product Card Locator    ${product_name}
    Wait Until Keyword Succeeds    15s    500ms    Click Remove And Wait For Add    ${product_name}    ${card}

Click Remove And Wait For Add
    [Arguments]    ${product_name}    ${card}
    Click Product Button    ${product_name}    remove
    Wait Until Element Is Visible    ${card}//button[starts-with(@data-test,"add-to-cart")]    2s

Verify Cart Badge Shows
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    ${CART_BADGE}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${CART_BADGE}    ${expected_count}

Verify Cart Badge Is Hidden
    Wait Until Element Is Not Visible    ${CART_BADGE}    ${DEFAULT_TIMEOUT}

Product Card Locator
    [Arguments]    ${product_name}
    RETURN    xpath://div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space()="${product_name}"]]

