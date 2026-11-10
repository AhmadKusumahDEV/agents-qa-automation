*** Settings ***
Documentation     Contoh smoke test untuk project baru.
Resource          ../../resources/common.resource
Resource          ../../resources/pages/example_page.resource
Test Setup        Open Test Browser
Test Teardown     Close Test Browser

*** Test Cases ***
Halaman Utama Terbuka
    [Tags]    smoke    template
    Open Home Page
    Page Should Contain Element    ${EXAMPLE_HEADING}

