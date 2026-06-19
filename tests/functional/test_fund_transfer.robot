*** Settings ***
Resource    ../../resources/pages/TransferFundPage.robot
Resource    ../../resources/pages/LoginPage.robot
Resource    ../../resources/pages/OpenAccountPage.robot
Resource    ../../resources/pages/AccountOverviewPage.robot

Suite Setup  Run Keywords
    ...  Load Environment   AND
    ...  Open Application
Suite Teardown  Close Application

*** Test Cases ***
TC-TF-UI-01 - Verify Fund Transfer Between Two Accounts
    [Documentation]     verifying the transfer of funds from one account to another
    [Tags]      functional
    Log In To Para Bank     bbq  demo

    ${login_success}=    Run Keyword And Return Status
    ...    Page Should Contain    Accounts Overview

    IF    not ${login_success}
        Register
        Open Checking Account Page
        Open Saving Account Page
    END

    Check Balance All
    Fund Transfer   100

TC-TF-UI-02 - Verify Transfer Confirmation Page Details
    [Documentation]     verifying the transfer of funds confirmation page
    [Tags]      functional
    Page Should Contain    has been transferred from account
TC-TF-UI-03 - Verify Updated Balance on Account Overview Page
    [Documentation]     verifying the transfer of funds from one account to another show up in the accounts overview page
    [Tags]      functional
    Check Balance