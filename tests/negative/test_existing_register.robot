*** Settings ***
Resource    ../../resources/pages/LoginPage.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup     Load Environment
Test Setup  Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-NEG-02 - Registration with Existing Username
    [Documentation]  Test case for registration with existing username
    [Tags]  negative
    Register
    Page Should Not Contain    Account Overview