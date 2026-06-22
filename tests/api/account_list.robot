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
    [Documentation]  Test case for retrieving account list successfully
    [Tags]  api
    Create API Session
    #there is an api for login but not for registration
    Check Login
    Retrieve Account List

TC-API-02 - Validate Newly Created Account Exists in API
    [Documentation]  Test case for validating newly created account exists in API
    [Tags]  api
    Create API Session
    Check Login
    Retrieve Account List
    Existence of Newly Created Account

TC-API-03 - Validate Account Type in API Response
    [Documentation]  Test case for validating account type in API response
    [Tags]  api
    Create API Session
    Check Login
    Retrieve Account List
    Account Type    SAVINGS

TC-API-04 - Validate Account Balance is Numeric and Non-Negative
    [Documentation]  Test case for validating account balance is numeric and non-negative
    [Tags]  defect
    Create API Session
    Check Login
    Retrieve Account List
    ${an_account}=    Get From List    ${ACCOUNTS}    0
    ${acc_id}=    Get From Dictionary    ${an_account}    id
    Is Account Balance Valid    ${acc_id}
TC-API-05 - Validate Invalid Account ID Returns Error
    [Documentation]  Test case for validating invalid account id returns error
    [Tags]  api
    Create API Session
    Check Login
    Is Account Valid    1
