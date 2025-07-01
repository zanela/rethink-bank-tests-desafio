*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    BuiltIn

*** Variables ***
${HEADERS}    Content-Type=application/json

*** Keywords ***
Iniciar Sessao
    [Arguments]    ${alias}    ${url}
    Create Session    ${alias}    ${url}    headers=${HEADERS}

Logar e Salvar Token
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    bank    /login    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    To Json    ${response.content}
    ${token}=    Get From Dictionary    ${body}    token
    Set Suite Variable    ${AUTH_TOKEN}    ${token}