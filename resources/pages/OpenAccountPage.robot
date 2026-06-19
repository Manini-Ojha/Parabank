*** Settings ***
Library  SeleniumLibrary
Resource  ../../locators/registeration_loc.robot
Resource  ../../locators/login_loc.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource    ../../locators/open_acc_loc.robot

*** Keywords ***
Open Checking Account Page
    [Documentation]  Open account page of Para Bank application
    Click Element    ${open_account_link}
    Wait Until Element Is Visible    ${open_account_btn}    10s
    Select From List By Value    id=type    0
    Click Element    ${open_account_btn}
    Sleep    5s
    Page Should Contain    Congratulations, your account is now open.


Open Saving Account Page
    [Documentation]  Open account page of Para Bank application
    Click Element    ${open_account_link}
    Wait Until Element Is Visible    ${open_account_btn}    10s
    Select From List By Value    id=type    1
    Click Element    ${open_account_btn}
    Sleep    5s
    Page Should Contain    Congratulations, your account is now open.

