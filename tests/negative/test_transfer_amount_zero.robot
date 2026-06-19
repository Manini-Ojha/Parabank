*** Settings ***
Resource    ../../resources/pages/TransferFundPage.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown   Close Application

*** Test Cases ***
TC-NEG-03 - Transfer Amount as Zero
    Log In To Para Bank     bbq  demo

    ${login_success}=    Run Keyword And Return Status
    ...    Page Should Contain    Accounts Overview

    IF    not ${login_success}
        Register
        Open Checking Account Page
        Open Saving Account Page
    END
    Fund Transfer  0
    Page Should Not Contain    has been transferred from account

TC-NEG-04 - Access Transfer Funds Page Without Login
    Page Should Not Contain    ${transfer_fund_link}

TC-NEG-05 - Transfer amount greater than available balance
    Log In To Para Bank     bbq  demo

    ${login_success}=    Run Keyword And Return Status
    ...    Page Should Contain    Accounts Overview

    IF    not ${login_success}
        Register
        Open Checking Account Page
        Open Saving Account Page
    END
    Fund Transfer    1000000000
    Page Should Not Contain    has been transferred from account