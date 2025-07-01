*** Variables ***
${BASE_URL}    https://points-app-backend.vercel.app
${CPF}         1234567${__import__('random').randint(1000,9999)}
${RECIPIENT_CPF}    10987654321
${NAME}        Leonardo Teste
${EMAIL}       leonardo_${__import__('random').randint(1000,9999)}@test.com
${PASSWORD}    Senha@123