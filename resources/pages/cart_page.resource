*** Settings ***
Documentation     Page object halaman keranjang.
Library           SeleniumLibrary

*** Variables ***
${CART_LIST}           css:[data-test="cart-list"]
${CART_ITEM_NAME}      css:[data-test="inventory-item-name"]
${CHECKOUT_BUTTON}     css:[data-test="checkout"]
${CONTINUE_SHOPPING}   css:[data-test="continue-shopping"]

*** Keywords ***
Open Cart
    Click And Wait For Location    shopping-cart-link    cart.html
    Wait Until Element Is Visible    ${CART_LIST}    ${DEFAULT_TIMEOUT}
    Wait Until Page Is Ready

Verify Cart Contains Product
    [Arguments]    ${product_name}
    ${item}=    Cart Item Locator    ${product_name}
    Wait Until Page Contains Element    ${item}    ${DEFAULT_TIMEOUT}

Verify Cart Item Count
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    ${CART_ITEM_NAME}
    Should Be Equal As Integers    ${count}    ${expected_count}

Proceed To Checkout
    Click And Wait For Location    checkout    checkout-step-one
    Wait Until Element Is Visible    ${CHECKOUT_FIRST_NAME_INPUT}    ${DEFAULT_TIMEOUT}
    Wait Until Page Is Ready

Continue Shopping
    Click And Wait For Location    continue-shopping    inventory.html
    Verify Inventory Page Is Displayed

Remove Product From Cart Page
    [Arguments]    ${product_name}
    ${item}=    Cart Item Locator    ${product_name}
    Wait Until Keyword Succeeds    15s    500ms    Click Remove In Cart And Wait For Removal    ${product_name}    ${item}

Click Remove In Cart And Wait For Removal
    [Arguments]    ${product_name}    ${item}
    Click Product Button    ${product_name}    remove
    Wait Until Page Does Not Contain Element    ${item}    2s

Cart Item Locator
    [Arguments]    ${product_name}
    RETURN    xpath://div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space()="${product_name}"]]

