*** Settings ***
Library  SeleniumLibrary
Resource  ../../locators/registeration_loc.robot
Resource  ../../locators/login_loc.robot
Resource  ../../resources/keywords/common_keywords.robot

*** Keywords ***
Register
    [Documentation]  Registering to Para Bank account
    Sleep    3s
    Double Click Element    ${register_link}
    Wait Until Element Is Visible    ${first_name}  10s
    Click Element    ${first_name}
    Input Text    ${first_name}    bbq
    Input Text    ${last_name}    bbq
    Input Text    ${address}    Bombay
    Input Text    ${city}    Bombay
    Input Text    ${state}    Maharashtra
    Input Text    ${zip_code}    400001
    Input Text    ${phone}    9876543210
    Input Text    ${ssn}    123456789
    Input Text    ${username}    bbq
    Input Text    ${password}    demo
    Input Text    ${confirm_password}    demo
    Click Element    ${register_btn}


Log in to Para Bank
    [Documentation]  logging in to Para Bank account
    [Arguments]     ${USER}  ${PAWD}
    Input Text    ${usern}    ${USER}
    Input Text    ${pwd}    ${PAWD}
    Click Element    ${login_btn}
