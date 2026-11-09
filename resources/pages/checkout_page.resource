*** Settings ***
Documentation     Page object alur checkout: form data, ringkasan, selesai.
Library           SeleniumLibrary

*** Variables ***
${CHECKOUT_FIRST_NAME_INPUT}    css:[data-test="firstName"]
${CHECKOUT_LAST_NAME_INPUT}     css:[data-test="lastName"]
${CHECKOUT_POSTAL_INPUT}        css:[data-test="postalCode"]
${CHECKOUT_CONTINUE}            css:[data-test="continue"]
${CHECKOUT_FINISH}              css:[data-test="finish"]
${CHECKOUT_COMPLETE}            css:[data-test="complete-header"]
${CHECKOUT_SUMMARY}             css:[data-test="checkout-summary-container"]
${CHECKOUT_ERROR}               css:[data-test="error"]

*** Keywords ***
Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Input Text    ${CHECKOUT_FIRST_NAME_INPUT}    ${first_name}
    Input Text    ${CHECKOUT_LAST_NAME_INPUT}    ${last_name}
    Input Text    ${CHECKOUT_POSTAL_INPUT}    ${postal_code}
    Submit Checkout Information

Submit Checkout Information
    [Documentation]    Klik Continue lalu terima dua hasil yang sah: lanjut ke
    ...                ringkasan, atau tertahan dengan pesan error validasi.
    Wait Until Keyword Succeeds    15s    500ms    Click Continue And Expect Response

Click Continue And Expect Response
    Click Test Id    continue
    Wait Until Keyword Succeeds    4s    200ms    Checkout Step Responded

Checkout Step Responded
    ${advanced}=    Run Keyword And Return Status    Wait Until Location Contains    checkout-step-two    1s
    ${blocked}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${CHECKOUT_ERROR}    1s
    Should Be True    ${advanced} or ${blocked}

Verify Checkout Overview Is Displayed
    Wait Until Element Is Visible    ${CHECKOUT_SUMMARY}    ${DEFAULT_TIMEOUT}
    Wait Until Page Is Ready

Verify Checkout Overview Contains Product
    [Arguments]    ${product_name}
    ${item}=    Set Variable
    ...    xpath://div[@data-test="inventory-item"][.//div[@data-test="inventory-item-name" and normalize-space()="${product_name}"]]
    Wait Until Page Contains Element    ${item}    ${DEFAULT_TIMEOUT}

Finish Checkout
    Click And Wait For Location    finish    checkout-complete

Verify Order Completed
    Wait Until Element Is Visible    ${CHECKOUT_COMPLETE}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${CHECKOUT_COMPLETE}    ${CHECKOUT_COMPLETE_TEXT}

Verify Checkout Error Contains
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${CHECKOUT_ERROR}    ${DEFAULT_TIMEOUT}
    Element Should Contain    ${CHECKOUT_ERROR}    ${expected_text}

