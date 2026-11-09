*** Settings ***
Documentation     Validasi form checkout. Fokus pada pesan error yang terlihat user.
Resource          ../../resources/common.resource

*** Test Cases ***
Checkout Tanpa Nama Depan Menampilkan Error
    [Tags]    regression    checkout    negative    TC-CHECKOUT-002
    Login As Standard User
    Add Product To Cart    Sauce Labs Backpack
    Open Cart
    Proceed To Checkout
    Fill Checkout Information    ${EMPTY}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}
    Verify Checkout Error Contains    ${ERROR_FIRST_NAME_REQUIRED}

Checkout Tanpa Kode Pos Menampilkan Error
    [Tags]    regression    checkout    negative    TC-CHECKOUT-003
    Login As Standard User
    Add Product To Cart    Sauce Labs Backpack
    Open Cart
    Proceed To Checkout
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${EMPTY}
    Verify Checkout Error Contains    ${ERROR_POSTAL_CODE_REQUIRED}
