*** Settings ***
Library    SeleniumLibrary
Library    DataDriver   file=${EXECDIR}/testdata/login_data.csv  dialect=excel

Resource    resources/keywords/common_keywords.robot
Resource    resources/pages/LoginPage.robot
Resource    locators/registeration_loc.robot

Suite Setup     Load Environment
Test Setup    Open Application
Test Teardown  Close Application

Test Template  Register User

*** Test Cases ***
Test Case For Data Driven   ${UserFirstname}    ${UserLastname}    ${UserAddress}    ${UserCity}    ${UserState}    ${UserZipcode}    ${Phno}    ${UserSSN}    ${User_name}    ${UserPwd}    ${Confirm}
   [Documentation]      Data driven testing using csv
   [Tags]   datadriver

*** Keywords ***
    
Register User
    [Arguments]    ${UserFirstname}    ${UserLastname}    ${UserAddress}    ${UserCity}    ${UserState}    ${UserZipcode}    ${Phno}    ${UserSSN}    ${UserUsername}    ${UserPwd}    ${Confirm}
    Double Click Element    ${register_link}
    Wait Until Element Is Visible    ${first_name}     10s
    Click Element    ${first_name}
    Input Text    ${first_name}   ${UserFirstname}
    Input Text    ${last_name}  ${UserLastname}
    Input Text    ${address}  ${UserAddress}
    Input Text    ${City}  ${UserCity}
    Input Text    ${state}  ${UserState}
    Input Text    ${zip_code}  ${UserZipcode}
    Input Text    ${phone}  ${Phno}
    Input Text    ${ssn}  ${UserSSN}
    Input Text    ${username}  ${User_name}
    Input Text    ${password}  ${UserPwd}
    Input Text    ${confirm_password}  ${Confirm}
    Click Element  ${register_btn}






