*** Settings ***
Resource    ../../resources/pages/AccountOverviewPage.robot
Resource   ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/LoginPage.robot
Resource    ../../resources/pages/OpenAccountPage.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-API-01 - Retrieve Account List Successfully
    Create API Session
    #there is an api for login but not for registration

    Log In To Para Bank  bbq  demo

    ${login_failed}=    Run Keyword And Return Status
    ...    Page Should Contain    The username and password could not be verified.

    IF    ${login_failed}
        Register
    END
    Retrieve Account List

TC-API-02 - Validate Newly Created Account Exists in API
    Create API Session
    Check Login
    Existence of Newly Created Account
    Retrieve Account List
TC-API-03 - Validate Account Type in API Response
    Create API Session
    Check Login
    Retrieve Account List
    Account Type    SAVINGS

TC-API-04 - Validate Account Balance is Numeric and Non-Negative
    Create API Session
    Check Login
    Retrieve Account List
    ${an_account}=    Get From List    ${ACCOUNTS}    0
    ${acc_id}=    Get From Dictionary    ${an_account}    id
    Is Account Balance Valid    ${acc_id}
TC-API-05 - Validate Invalid Account ID Returns Error
    Create API Session
    Check Login
    Is Account Valid    1