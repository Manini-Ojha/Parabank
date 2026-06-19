*** Settings ***
Library     SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../locators/transfer_fund_loc.robot
Resource    ../../locators/accounts_overview_loc.robot


*** Keywords ***
Access Transfer Funds Page
    Wait Until Element Is Visible    ${transfer_fund_link}    10s
    Click Element    ${transfer_fund_link}

Fund Transfer
    [Arguments]     ${MONEY}
    Access Transfer Funds Page
    Wait Until Element Is Visible    ${amount}  10s
    Input Text    ${amount}    ${MONEY}
    Wait Until Element Is Visible    ${selectfrom}  10s
    Wait Until Element Is Visible    ${selectto}    10s



    ${items}=    Get List Items    id=fromAccountId
    Log To Console    From Accounts: ${items}

    ${items2}=    Get List Items    id=toAccountId
    Log To Console    To Accounts: ${items2}



    Select From List By Index    id=fromAccountId   0
    ${from_account}=    Get Selected List Value    id=fromAccountId
    Set Suite Variable    ${FROM_ACCOUNT}    ${from_account}

    Select From List By Index    id=toAccountId     1
    ${to_account}=    Get Selected List Value    id=toAccountId
    Set Suite Variable    ${TO_ACCOUNT}    ${to_account}

    Click Element    ${transfer_fund_btn}

    Log To Console    From Account: ${from_account}
    Log To Console    To Account: ${to_account}
Tranfer Success Confirmation
    Page Should Contain    ${FROM_ACCOUNT}
    Page Should Contain    ${TO_ACCOUNT}
    Page Should Contain    ${amount}

Check Balance
    Click Element    ${accounts_overview}
    Wait Until Element Is Visible    ${overview_table}  10s

    ${from_balance}=    Get Text
    ...    xpath=//a[text()='${FROM_ACCOUNT}']/../following-sibling::td[1]

    ${to_balance}=    Get Text
    ...    xpath=//a[text()='${TO_ACCOUNT}']/../following-sibling::td[1]

    Log To Console    From Balance: ${FROM_ACCOUNT}
    Log To Console    To Balance: ${TO_ACCOUNT}