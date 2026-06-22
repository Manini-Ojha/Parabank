*** Settings ***
Resource    ../../resources/pages/TransferFundPage.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown   Close Application

*** Test Cases ***
TC-NEG-03 - Transfer Amount as Zero.
    [Documentation]  Test case for transfer of funds from one account to another with amount as zero
    [Tags]    defect
    Check Login And Ensure Multiple Accounts
    Fund Transfer  0
    Page Should Not Contain    has been transferred from account

TC-NEG-04 - Access Transfer Funds Page Without Login
    [Documentation]  Test case for accessing transfer funds page without login
    [Tags]    negative
    Page Should Not Contain    ${transfer_fund_link}

TC-NEG-05 - Transfer amount greater than available balance
    [Documentation]  Test case for transfer of funds from one account to another with amount greater than available balance
    [Tags]    defect
    Check Login And Ensure Multiple Accounts
    Fund Transfer    1000000000
    Page Should Not Contain    has been transferred from account