*** Settings ***
Documentation     Contoh page object. Ganti dengan halaman sungguhan.
Library           SeleniumLibrary

*** Variables ***
${EXAMPLE_HEADING}    css:h1

*** Keywords ***
Open Home Page
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${EXAMPLE_HEADING}    ${DEFAULT_TIMEOUT}

