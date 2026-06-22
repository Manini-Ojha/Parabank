*** Settings ***
Library  SeleniumLibrary
Library  ../../config/environment.py
Resource  ../../resources/pages/LoginPage.robot
Resource    api_keywords.robot

*** Variables ***
${BROWSER}  chrome
${ENV}  qa

*** Keywords ***
Load Environment
    Load Env    ${ENV}
    ${url}=  Get Env    baseurl
    ${phone_no}=  Get Env    ph_no

    Set Global Variable    ${BASE_URL}  ${url}
    Set Global Variable    ${USER_EMAIL}  ${phone_no}
    Log    Loaded BASE_URL=${BASE_URL}

Open Application
    [Documentation]  Opens the application
    Should Not Be Empty    ${BASE_URL}    Base URL must not be empty. Please set it in config/env.yaml
    Open Browser  ${BASE_URL}  ${BROWSER}
    Maximize Browser Window
    Sleep    5s


Close Application
    [Documentation]  Closing the application
    Close All Browsers

Check Login
    #Wait for username field, perform login, and wait for Accounts Overview page.
    #If it fails, register the user. If registration fails (e.g. because another thread registered the user in parallel),
    #navigate back to the home page and try logging in again.
    Wait Until Element Is Visible    ${usern}    10s
    Log In To Para Bank     bbq     demo
    ${login_success}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${accounts_overview}    10s
    IF    not ${login_success}
        Register
        ${reg_success}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${accounts_overview}    10s
        IF    not ${reg_success}
            Go To    ${BASE_URL}
            Wait Until Element Is Visible    ${usern}    10s
            Log In To Para Bank     bbq     demo
            Wait Until Element Is Visible    ${accounts_overview}    10s
        END
    END

Check Login And Ensure Multiple Accounts
    #New keyword to guarantee the logged-in user has at least 2 accounts (checking & savings).
    #prevents 'index out of range' errors when executing UI fund transfers if the user only has 1 account.
    Check Login
    Wait Until Element Is Visible    xpath=//a[text()="Transfer Funds"]    10s
    Click Element    xpath=//a[text()="Transfer Funds"]
    Wait Until Element Is Visible    id=fromAccountId    10s
    Sleep    2s
    ${items}=    Get List Items    id=fromAccountId
    ${count}=    Get Length    ${items}
    IF    ${count} < 2
        Open Checking Account Page
        Open Saving Account Page
    END
