*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/TransferFundPage.robot
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup     Load Environment
Test Setup      Open Application
Test Teardown   Close Application

*** Variables ***
${money}    100

*** Test Cases ***
TC-E2E-01 - Validate API Reflects Correct Debit After UI Transfer
    Log In To Para Bank     bbq  demo

    ${login_success}=    Run Keyword And Return Status
    ...    Page Should Contain    Accounts Overview

    IF    not ${login_success}
        Register
        Open Checking Account Page
        Open Saving Account Page
    END

#    Create API Session
#
#
#    ${balance_before}=    Check Account Balance    ${FROM_ACCOUNT}
#    Log To Console    Balance: ${balance_before}
#
#    Fund Transfer   ${money}
#
#    ${balance_after}=   Check Account Balance    ${FROM_ACCOUNT}
#    Should Be Equal As Integers    ${money}    ${balance_before}-${balance_after}
#
#    Log To Console    Balance: ${balance_after}
#    Log To Console    Funds Transferred: ${money}
#    Log To Console    Difference between balances: ${balance_before}-${balance_after}
    Create API Session
    Retrieve Account List

    # capture FROM_ACCOUNT id + its balance from the API list BEFORE transfer
    ${an_account}=    Get From List    ${ACCOUNTS}    0
    ${acc_id}=    Get From Dictionary    ${an_account}    id
    ${balance_before}=    Check Account Balance    ${acc_id}

    Fund Transfer    ${money}

    # after transfer, refresh and check the SAME account id
    Retrieve Account List
    ${balance_after}=    Check Account Balance    ${acc_id}

    ${expected_balance}=    Evaluate    ${balance_before} - ${money}
    Should Be Equal As Numbers    ${balance_after}    ${expected_balance}

    Log To Console    Before: ${balance_before}, After: ${balance_after}, Transferred: ${money}

TC-E2E-02 - Validate API Reflects Correct Credit After UI Transfer
    Log In To Para Bank     bbq  demo

    ${login_success}=    Run Keyword And Return Status
    ...    Page Should Contain    Accounts Overview

    IF    not ${login_success}
        Register
        Open Checking Account Page
        Open Saving Account Page
    END

    Create API Session
    Retrieve Account List

    # capture FROM_ACCOUNT id + its balance from the API list BEFORE transfer
    ${an_account}=    Get From List    ${ACCOUNTS}    1
    ${acc_id}=    Get From Dictionary    ${an_account}    id
    ${balance_before}=    Check Account Balance    ${acc_id}

    Fund Transfer    ${money}

    # after transfer, refresh and check the SAME account id
    Retrieve Account List
    ${balance_after}=    Check Account Balance    ${acc_id}

    ${expected_balance}=    Evaluate    ${balance_after} - ${money}
    Should Be Equal As Numbers    ${balance_before}    ${expected_balance}

    Log To Console    Before: ${balance_before}, After: ${balance_after}, Transferred: ${money}

TC-HYB-03 - Create Account via UI and Validate Type & Balance via API
    Create API Session
    Check Login
    Open Saving Account Page
    ${newAccountId}=    Get Text    xpath=//a[@id='newAccountId']
    Set Suite Variable    ${newAccountId}
    Wait Until Keyword Succeeds    5x    1s    Retrieve Account List
    Is Account Balance Valid    ${newAccountId}
    Account Type    SAVINGS



