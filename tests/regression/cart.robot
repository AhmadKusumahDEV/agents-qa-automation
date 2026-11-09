*** Settings ***
Documentation     Perilaku keranjang: navigasi dan penghapusan item.
Resource          ../../resources/common.resource

*** Test Cases ***
Lanjut Belanja Kembali Ke Katalog
    [Tags]    regression    cart    TC-CART-002
    Login As Standard User
    Add Product To Cart    Sauce Labs Backpack
    Open Cart
    Continue Shopping
    Verify Inventory Page Is Displayed

Hapus Produk Dari Keranjang
    [Tags]    regression    cart    TC-CART-003
    Login As Standard User
    Add Product To Cart    Sauce Labs Backpack
    Open Cart
    Verify Cart Item Count    1
    Remove Product From Cart Page    Sauce Labs Backpack
    Verify Cart Item Count    0
