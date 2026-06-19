*** Settings ***

Library  SeleniumLibrary
Resource  ../../resources/pages/LoginPage.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot

Suite Setup  Run Keywords
    ...  Load Environment   AND
    ...  Open Application
Suite Teardown  Close Application

*** Test Cases ***
TC-AC-UI-01 - Register and Login with Valid Details
    [Documentation]  Test case for login to notes application by UI and add a note
    [Tags]  functional
    Check Login
    Sleep  5s
