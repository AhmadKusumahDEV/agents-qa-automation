*** Settings ***
Documentation     Perilaku katalog: sorting dan badge keranjang.
Resource          ../../resources/common.resource

*** Test Cases ***
Urutkan Produk Dari Harga Termurah
    [Tags]    regression    inventory    TC-INVENTORY-001
    Login As Standard User
    Sort Products By    lohi
    Wait Until Keyword Succeeds    5s    200ms    First Product Name Should Be    Sauce Labs Onesie
    ${price}=    Get First Product Price
    Should Be Equal    ${price}    $7.99

Tambah Dan Hapus Produk Memperbarui Badge
    [Tags]    regression    cart    TC-CART-001
    Login As Standard User
    Add Product To Cart    Sauce Labs Backpack
    Verify Cart Badge Shows    1
    Add Product To Cart    Sauce Labs Bike Light
    Verify Cart Badge Shows    2
    Remove Product From Cart    Sauce Labs Backpack
    Verify Cart Badge Shows    1
