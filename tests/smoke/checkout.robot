*** Settings ***
Documentation     Alur bisnis utama: pilih produk sampai pesanan selesai.
Resource          ../../resources/common.resource

*** Test Cases ***
Checkout Satu Produk Sampai Selesai
    [Documentation]    Happy path end-to-end dari login sampai halaman sukses.
    [Tags]    smoke    checkout    e2e    TC-CHECKOUT-001
    Login As Standard User
    Add Product To Cart    Sauce Labs Backpack
    Verify Cart Badge Shows    1
    Open Cart
    Verify Cart Contains Product    Sauce Labs Backpack
    Proceed To Checkout
    Fill Checkout Information    ${CHECKOUT_FIRST_NAME}    ${CHECKOUT_LAST_NAME}    ${CHECKOUT_POSTAL_CODE}
    Verify Checkout Overview Is Displayed
    Verify Checkout Overview Contains Product    Sauce Labs Backpack
    Finish Checkout
    Verify Order Completed
