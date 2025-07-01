# 🤖 Rethink Bank Test - Automação E2E com Robot Framework

Este repositório contém testes automatizados de ponta a ponta (E2E) da jornada de um usuário no sistema Rethink Bank, com base na API pública hospedada em:  
🔗 https://points-app-backend.vercel.app

## 📋 Sumário

- [🚀 Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [📁 Estrutura do Projeto](#-estrutura-do-projeto)
- [🧪 Casos de Teste Automatizados](#-casos-de-teste-automatizados)
- [⚙️ Instalação e Execução dos Testes](#️-instalação-e-execução-dos-testes)
- [✅ Evidências e Relatórios](#-evidências-e-relatórios)
- [❓ Respostas Obrigatórias](#-respostas-obrigatórias)
- [📌 Observações](#-observações)

## 🚀 Tecnologias Utilizadas

- Robot Framework
- RequestsLibrary
- JSONLibrary
- Python 3.8+

## 📁 Estrutura do Projeto

```
rethink-bank-tests/
├── tests/
│   └── jornada_usuario.robot
├── resources/
│   ├── keywords.resource
│   └── variables.resource
├── README.md
└── requirements.txt
```

## 🧪 Casos de Teste Automatizados

1. Cadastro de novo usuário
2. Confirmação de e-mail
3. Login e obtenção de token
4. Envio de pontos a outro CPF
5. Depósito na caixinha
6. Consulta de saldo
7. Consulta de extratos (pontos e caixinha)
8. Resgate de pontos da caixinha
9. Exclusão de conta

## ⚙️ Instalação e Execução dos Testes

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/rethink-bank-tests.git
cd rethink-bank-tests
```

### 2. Crie um ambiente virtual (opcional)
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate   # Windows
```

### 3. Instale as dependências
```bash
pip install -r requirements.txt
```

### 4. Execute os testes
```bash
robot tests/jornada_usuario.robot
```

## ✅ Evidências e Relatórios

Os testes geram os arquivos:
- `log.html`
- `report.html`
- `output.xml`

## ❓ Respostas Obrigatórias

### a. Há bugs?  
Sim. Os seguintes comportamentos inesperados foram identificados:

| Cenário                              | Esperado                        | Observado                         | Criticidade |
|-------------------------------------|----------------------------------|------------------------------------|-------------|
| Envio para CPF inexistente          | Erro de usuário inválido         | Sucesso inesperado                 | Alta        |
| Reutilização de token expirado      | Erro 401                         | Retorno 200 mesmo expirado         | Crítica     |
| Exclusão sem token                  | Erro 401                         | Retorno 500                        | Média       |

### b. Classificação

- Alta: quebra de integridade (CPF inválido)
- Crítica: falha de segurança (token)
- Média: falha de tratamento (500 → 401)

### c. Está pronto para produção?
**Não.** Há falhas de segurança, integridade e mensagens de erro.

## 📌 Observações

- Token expira em 10 minutos.
- Testes sequenciais.
- Variáveis dinâmicas (email e CPF).
- Implementado em Robot Framework.

## 🧑‍💻 Autor

**Leonardo Zanela**  
QA Engineer | Automação de Testes  
📫 [linkedin.com/in/leonardozanela](https://linkedin.com/in/leonardozanela)