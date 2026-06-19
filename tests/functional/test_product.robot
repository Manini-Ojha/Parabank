*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/pages/LoginPage.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-AC-UI-02 - Create Savings Account
    [Documentation]  Test case for login to notes application by UI and add a note
    [Tags]  functional
    Check Login
    Open Checking Account Page

TC-AC-UI-03 - Create Checking Account
    [Documentation]  Test case for login to notes application by UI and add a note
    [Tags]  functional
    Check Login
    Open Saving Account Page
