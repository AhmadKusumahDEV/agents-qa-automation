*** Settings ***
Documentation     Smoke test autentikasi SauceDemo.
Resource          ../../resources/common.resource

*** Test Cases ***
Login Berhasil Dengan Kredensial Valid
    [Documentation]    User standar bisa masuk dan melihat enam produk.
    [Tags]    smoke    login    positive    TC-LOGIN-001
    Login With Credentials    ${STANDARD_USER}    ${STANDARD_PASSWORD}
    Verify Inventory Page Is Displayed
    Verify Product Count    6

Login Gagal Untuk User Terkunci
    [Documentation]    locked_out_user ditolak dengan pesan yang jelas.
    [Tags]    smoke    login    negative    TC-LOGIN-002
    Login With Credentials    ${LOCKED_USER}    ${STANDARD_PASSWORD}
    Verify Login Error Contains    ${ERROR_LOCKED_OUT}

Login Gagal Dengan Password Salah
    [Tags]    regression    login    negative    TC-LOGIN-003
    Login With Credentials    ${STANDARD_USER}    password_salah
    Verify Login Error Contains    ${ERROR_INVALID_CREDENTIALS}

Login Gagal Dengan Username Kosong
    [Tags]    regression    login    negative    TC-LOGIN-004
    Go To Login Page
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${STANDARD_PASSWORD}
    Click Button    ${LOGIN_BUTTON}
    Verify Login Error Contains    ${ERROR_USERNAME_REQUIRED}
