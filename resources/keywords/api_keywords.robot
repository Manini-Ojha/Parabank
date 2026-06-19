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

#Get Customer Id
#    [Arguments]  ${account_id}
#    ${response}=    GET Account Details
#    ...  ${account_id}
#    ${body}=  Evaluate    ${response.json()}
#    ${customer_id}=  Set Variable
#    ...     ${body}[customerId]
#    Set Suite Variable      ${CUSTOMER_ID}      ${customer_id}
#
#Get Account Details
#    [Arguments]     ${account_id}
#    ${response}=  GET On Session  parabank_api
#    ...  /parabank/services/bank/accounts/${account_id}
#
#    RETURN  ${response}

Retrieve Account List

    ${response1}=    GET On Session
    ...    parabank_api
    ...    /login/bbq/demo

    Should Be Equal As Integers    ${response1.status_code}    200

    ${json_data}=    Evaluate    $response1.json()

    ${customerId}=    Get From Dictionary    ${json_data}    id

    Log To Console    Customer ID = ${customerId}

    ${response2}=    GET On Session
    ...    parabank_api
    ...    /customers/${customerId}/accounts

    Should Be Equal As Integers    ${response2.status_code}    200

    ${accounts}=    Evaluate    $response2.json()
    Set Suite Variable    ${ACCOUNTS}   ${accounts}
    Log To Console    ${ACCOUNTS}
#    RETURN    ${response2}

Existence of Newly Created Account
    Open Saving Account Page
    ${newAccountId}=    Get Text
    ...    xpath=//a[@id='newAccountId']

    Set Suite Variable    ${newAccountId}
    Retrieve Account List
    ${found}=    Set Variable    ${False}
    FOR    ${account}    IN    @{ACCOUNTS}
        ${id}=    Get From Dictionary    ${account}    id
        IF    '${id}' == '${newAccountId}'
            ${found}=    Set Variable    ${True}
            Exit For Loop
        END
    END
    Should Be True    ${found}


Account Type
    [Arguments]    ${expectedType}
    Open Saving Account Page
    ${newAccountId}=    Get Text    xpath=//a[@id='newAccountId']
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
            Should Be True    ${acc_balance} > 0
            Log To Console    ${acc_balance}
            Exit For Loop
        END
    END

Is Account Valid
    [Arguments]    ${acc_id}
    ${response}=    GET On Session    parabank_api    /accounts/${acc_id}    expected_status=any
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

