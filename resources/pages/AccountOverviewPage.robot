*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library    Collections
Resource    ../../resources/keywords/api_keywords.robot
Resource  ../../locators/accounts_overview_loc.robot
Library    XML

#*** Keywords ***
#Retrieve Account List
#    Create Session    parabank_api    ${api_url}    verify=False
#    ${response1} =   GET on Session  parabank_api    /login/bbq/demo
#    Should Be Equal As Integers     ${response1.status_code}     200
#
#    ${body}=  Set Variable  ${response1.xml()}
#    Log To Console    ${body}
#
#    ${customer_id}=  Get From Dictionary  ${body}   id
#
#    Set Global Variable    ${CUSTOMER_ID}    ${customer_id}
#
#    ${response2} =   GET on Session  parabank_api    /accounts/{accountId}
#    Should Be Equal As Integers     ${response2.status_code}     200
#
#    ${body}=  Set Variable  ${response2.xml()}
#    Log To Console    ${body}
#*** Settings ***
#Library    RequestsLibrary
#Library    Collections

*** Keywords ***
#API


Check Account Exists API


#UI
Check Balance ALl
    Click Element    ${accounts_overview}
    ${rows}=    Get Element Count    xpath=//table[@id='accountTable']/tbody/tr

    FOR    ${i}    IN RANGE    1    ${rows}+1
        ${account}=    Get Text    xpath=//table[@id='accountTable']/tbody/tr[${i}]/td[1]
        ${balance}=    Get Text    xpath=//table[@id='accountTable']/tbody/tr[${i}]/td[2]

        Log To Console    Account: ${account} | Balance: ${balance}
    END