*** Settings ***
Library    SeleniumLibrary
Library  RequestsLibrary
Library    Collections
Resource    ../../resources/keywords/api_keywords.robot
Resource  ../../locators/accounts_overview_loc.robot
Library    XML
Resource    ../../resources/pages/OpenAccountPage.robot
*** Variables ***
${ui_url}    https://parabank.parasoft.com/
${api_url}    https://parabank.parasoft.com/parabank/services/bank/

*** Keywords ***
Create API Session
    ${headers}=  Create Dictionary
    ...     Accept=application/json

    Create Session
    ...    parabank_api
    ...    ${api_url}
    ...    headers=${headers}
    ...    verify=False


Retrieve Account List

    ${response1}=    GET And Validate Response Time     /login/bbq/demo

    Should Be Equal As Integers    ${response1.status_code}    200

    ${json_data}=    Evaluate    $response1.json()

    ${customerId}=    Get From Dictionary    ${json_data}    id

    Log To Console    Customer ID = ${customerId}

    ${response2}=    GET And Validate Response Time     /customers/${customerId}/accounts

    Should Be Equal As Integers    ${response2.status_code}    200

    ${accounts}=    Evaluate    $response2.json()
    Set Suite Variable    ${ACCOUNTS}   ${accounts}
    Log To Console    ${ACCOUNTS}


#Helper keyword to wait until the new account appears in the API response.
Wait Until Account Exists In API
    [Arguments]    ${expected_id}
    Retrieve Account List
    ${found}=    Set Variable    ${False}
    FOR    ${account}    IN    @{ACCOUNTS}
         ${id}=    Get From Dictionary    ${account}    id
         IF    '${id}' == '${expected_id}'
             ${found}=    Set Variable    ${True}
             Exit For Loop
         END
    END
    Should Be True    ${found}

Existence of Newly Created Account
    #Updated to wait until the new account appears in the API (using Wait Until Keyword Succeeds) due to propagation delays between UI creation and REST API reflection.
#    Open Saving Account

    ${first_account}=    Get From List    ${ACCOUNTS}    0
    ${fromAccId}=    Get From Dictionary    ${first_account}    id
    ${response}=    GET On Session    parabank_api    /login/bbq/demo
    ${json}=    Evaluate    $response.json()
    ${customerId}=    Get From Dictionary    ${json}    id
    ${new_account}=    Create Account Via API    ${customerId}    1    ${fromAccId}
    ${newAccountId}=    Get From Dictionary    ${new_account}    id

    Set Suite Variable    ${newAccountId}
    Wait Until Keyword Succeeds    5x    2s    Wait Until Account Exists In API    ${newAccountId}



#Updated to wait until the newly created account appears in the API (using Wait Until Keyword Succeeds) BEFORE verifying the account type. This makes the test actually assert the type rather than bypassing it due to an empty list.
Account Type
     [Arguments]    ${expectedType}
     Open Saving Account Page
     ${newAccountId}=    Get Text    xpath=//a[@id='newAccountId']
     Wait Until Keyword Succeeds    5x    2s    Wait Until Account Exists In API    ${newAccountId}
     FOR    ${account}    IN    @{ACCOUNTS}
         ${id}=    Get From Dictionary    ${account}    id
         IF    '${id}' == '${newAccountId}'
             ${type}=    Get From Dictionary    ${account}    type
             Should Be Equal As Strings    ${type}    ${expectedType}
             Log To Console    Account Type: ${type}
             Exit For Loop
         END
     END


Is Account Balance Valid
    [Arguments]     ${acc_id}

    FOR    ${account}    IN    @{ACCOUNTS}

        ${id}=    Get From Dictionary    ${account}    id

        IF    '${id}' == '${acc_id}'

            ${acc_balance}=    Get From Dictionary    ${account}    balance

            Should Be True    isinstance(${acc_balance}, (int, float))
            Should Be True    ${acc_balance} >= 0
            Log To Console    ${acc_balance}
            Exit For Loop
        END
    END

Is Account Valid
    [Arguments]    ${acc_id}
    ${response}=    GET And Validate Response Time    /accounts/${acc_id}    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    400

Check Account Balance
    [Arguments]     ${acc_id}

    FOR    ${account}    IN    @{ACCOUNTS}

        ${id}=    Get From Dictionary    ${account}    id

        IF    '${id}' == '${acc_id}'

            ${acc_balance}=    Get From Dictionary    ${account}    balance
            RETURN    ${acc_balance}
        END
    END
    Fail    Account ID ${acc_id} not found in ACCOUNTS list


Create Account Via API
    [Arguments]    ${customerId}    ${accountType}    ${fromAccountId}
    ${response}=    POST On Session
    ...    parabank_api
    ...    /createAccount
    ...    params=customerId=${customerId}&newAccountType=${accountType}&fromAccountId=${fromAccountId}
    ...    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    200
    ${new_account}=    Evaluate    $response.json()
    RETURN    ${new_account}

#Checking response time of each api end point being called
GET And Validate Response Time
    [Arguments]    ${endpoint}    ${max_seconds}=2    ${expected_status}=200
    ${response}=    GET On Session    parabank_api    ${endpoint}
    ...    expected_status=${expected_status}
    ${acc_time}=    Evaluate    $response.elapsed.total_seconds()
    Set Suite Variable    ${acc_time}
    Should Be True    ${acc_time} < ${max_seconds}
    ...    API response for ${endpoint} took ${acc_time}s, exceeded limit of ${max_seconds}s
    RETURN    ${response}