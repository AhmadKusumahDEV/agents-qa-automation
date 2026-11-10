*** Settings ***
Documentation     Keyword dasar untuk suite ini.
Library           SeleniumLibrary
Variables         ../variables/env.py

*** Keywords ***
Open Test Browser
    ${options}=    Set Variable    add_argument("--window-size=1440,900");add_argument("--disable-dev-shm-usage")
    IF    ${HEADLESS}
        ${options}=    Set Variable    ${options};add_argument("--headless=new")
    END
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}

Close Test Browser
    Run Keyword If Test Failed    Capture Page Screenshot    ${OUTPUT DIR}/FAILED-${TEST NAME}.png
    Close All Browsers

