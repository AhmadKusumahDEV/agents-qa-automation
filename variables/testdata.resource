*** Settings ***
Documentation     Data uji statis. SauceDemo menyediakan akun publik untuk latihan.

*** Variables ***
${STANDARD_USER}                 standard_user
${LOCKED_USER}                   locked_out_user
${PROBLEM_USER}                  problem_user
${STANDARD_PASSWORD}             secret_sauce

${CHECKOUT_FIRST_NAME}           QA
${CHECKOUT_LAST_NAME}            Learner
${CHECKOUT_POSTAL_CODE}          12345

${ERROR_LOCKED_OUT}              Sorry, this user has been locked out
${ERROR_INVALID_CREDENTIALS}     Username and password do not match any user in this service
${ERROR_USERNAME_REQUIRED}       Username is required
${ERROR_FIRST_NAME_REQUIRED}     Error: First Name is required
${ERROR_POSTAL_CODE_REQUIRED}    Error: Postal Code is required
${CHECKOUT_COMPLETE_TEXT}        Thank you for your order!
