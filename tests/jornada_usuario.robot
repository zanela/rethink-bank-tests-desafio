*** Settings ***
Resource    ../resources/variables.resource
Resource    ../resources/keywords.resource
Suite Setup    Iniciar Sessao    bank    ${BASE_URL}
Test Teardown    Sleep    1s

*** Test Cases ***
1 - Cadastro de Novo Usuário
    ${payload}=    Create Dictionary
    ...    cpf=${CPF}
    ...    full_name=${NAME}
    ...    email=${EMAIL}
    ...    password=${PASSWORD}
    ...    confirmPassword=${PASSWORD}
    ${response}=    POST On Session    bank    /cadastro    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    ${body}=    To Json    ${response.content}
    Set Suite Variable    ${CONFIRM_TOKEN}    ${body['confirmToken']}

2 - Confirmar E-mail
    ${response}=    GET On Session    bank    /confirm-email?token=${CONFIRM_TOKEN}
    Should Be Equal As Integers    ${response.status_code}    200

3 - Login e Obter Token
    Logar e Salvar Token    ${EMAIL}    ${PASSWORD}

4 - Consultar Saldo Inicial
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    bank    /points/saldo    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

5 - Depositar na Caixinha
    ${payload}=    Create Dictionary    amount=30
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    bank    /caixinha/deposit    json=${payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

6 - Resgatar da Caixinha
    ${payload}=    Create Dictionary    amount=10
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    bank    /caixinha/withdraw    json=${payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

7 - Enviar Pontos
    ${payload}=    Create Dictionary    recipientCpf=${RECIPIENT_CPF}    amount=50
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    POST On Session    bank    /points/send    json=${payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

8 - Ver Extrato de Pontos
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    bank    /points/extrato    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

9 - Ver Extrato da Caixinha
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    GET On Session    bank    /caixinha/extrato    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

10 - Excluir Conta
    ${payload}=    Create Dictionary    password=${PASSWORD}
    ${headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${response}=    DELETE On Session    bank    /account    json=${payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200