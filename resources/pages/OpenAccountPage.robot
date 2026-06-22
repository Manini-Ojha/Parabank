*** Settings ***
Library  SeleniumLibrary
Resource  ../../locators/registeration_loc.robot
Resource  ../../locators/login_loc.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource    ../../locators/open_acc_loc.robot

*** Keywords ***

#Added Wait to ensure the dynamic dropdown has loaded its options before we click submit. Also added Wait Until Element Is Visible for id=newAccountId to ensure the account was actually created.

 Open Checking Account Page
     [Documentation]  Open Checking account page of Para Bank application
     Click Element    ${open_account_link}
     Wait Until Element Is Visible    ${open_account_btn}    10s
     Wait Until Element Is Visible    ${options}    10s
     Select From List By Value    id=type    0
     Click Element    ${open_account_btn}
     Wait Until Element Is Visible    id=newAccountId    15s
     Page Should Contain    Congratulations, your account is now open.


 Open Saving Account Page
     [Documentation]  Open Savings account page of Para Bank application
     Click Element    ${open_account_link}
     Wait Until Element Is Visible    ${open_account_btn}    10s
     Wait Until Element Is Visible    ${options}    10s
     Select From List By Value    id=type    1
     Click Element    ${open_account_btn}
     Wait Until Element Is Visible    id=newAccountId    15s
     Page Should Contain    Congratulations, your account is now open.

