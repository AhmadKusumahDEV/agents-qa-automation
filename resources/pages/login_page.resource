*** Settings ***
Documentation     Page object halaman login SauceDemo.
Library           SeleniumLibrary

*** Variables ***
${LOGIN_USERNAME_INPUT}    css:[data-test="username"]
${LOGIN_PASSWORD_INPUT}    css:[data-test="password"]
${LOGIN_BUTTON}            css:[data-test="login-button"]
${LOGIN_ERROR}             css:[data-test="error"]

*** Keywords ***
Go To Login Page
    Go To    ${BASE_URL}
    Wait Until Element Is Visible    ${LOGIN_USERNAME_INPUT}    ${DEFAULT_TIMEOUT}
    Wait Until Page Is Ready

Login With Credentials
    [Arguments]    ${username}    ${password}
    Go To Login Page
    Input Text    ${LOGIN_USERNAME_INPUT}    ${username}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${password}
    Submit Login

Submit Login
    [Documentation]    Klik login lalu pastikan halaman benar-benar merespons.
    Wait Until Keyword Succeeds    15s    500ms    Click Login And Expect Response

Click Login And Expect Response
    Click Test Id    login-button
    Wait Until Keyword Succeeds    4s    200ms    Login Page Responded

Login Page Responded
    ${logged_in}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${INVENTORY_LIST}    1s
    ${has_error}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${LOGIN_ERROR}    1s
    Should Be True    ${logged_in} or ${has_error}

Login As Standard User
    Login With Credentials    ${STANDARD_USER}    ${STANDARD_PASSWORD}
    Verify Inventory Page Is Displayed

Verify Login Error Contains
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${LOGIN_ERROR}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${LOGIN_ERROR}    ${expected_text}

