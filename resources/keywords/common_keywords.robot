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
    Sleep    30


Close Application
    [Documentation]  Closing the application
    Close All Browsers

Check Login
    Log In To Para Bank     bbq     demo

    ${login_failed}=    Run Keyword And Return Status
    ...    Page Should Not Contain    Accounts Overview

    IF    ${login_failed}
        Register
        Page Should Contain    Welcome
    END

#Initialize API Suite
#    Create API Session
#    Open Application
#    Log in to Para Bank    bbq    demo