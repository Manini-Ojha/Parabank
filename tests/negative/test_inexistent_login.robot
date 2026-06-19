*** Settings ***
Resource  ../../resources/pages/LoginPage.robot
Resource    ../../resources/keywords/common_keywords.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-NEG-01 - Login with Non-Existent User
    Log in to Para Bank    bbg   twirl
    Page Should Not Contain    Accounts Overview
