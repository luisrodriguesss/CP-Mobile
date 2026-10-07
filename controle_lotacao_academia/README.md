# Gym Capacity 2.0

Aplicativo desenvolvido em Flutter para controle de lotação e gerenciamento de acessos em uma academia.

O projeto é uma evolução do Checkpoint 01, adicionando cadastro de pessoas, controle de entrada e saída, registro de horários, validação de capacidade máxima e gerenciamento dos registros.

## Ambiente escolhido

Academia.

Capacidade máxima definida no aplicativo:

50 pessoas.

## Funcionalidades

- Cadastro de pessoas com nome e identificação;
- Registro automático de data e hora de entrada;
- Controle de pessoas presentes no ambiente;
- Registro de saída;
- Exibição da data e hora de saída;
- Controle de capacidade máxima;
- Validação de campos obrigatórios;
- Validação de identificação duplicada;
- Lista de pessoas cadastradas;
- Feedback ao usuário com SnackBar;
- Confirmação de operações com AlertDialog;
- Ações laterais utilizando Slidable;
- Exclusão de registros;
- Interface personalizada para academia;
- Launcher icon personalizado.

## Regras de negócio

O aplicativo respeita as seguintes regras:

- A quantidade de pessoas dentro da academia não pode ultrapassar 50;
- Não é possível cadastrar uma pessoa sem preencher nome e identificação;
- Não é possível cadastrar duas pessoas com a mesma identificação simultaneamente;
- Uma pessoa que já saiu não pode registrar uma nova saída;
- O contador de pessoas presentes é atualizado automaticamente;
- Operações importantes solicitam confirmação ao usuário.

## Estrutura do projeto

```text
lib/
├── main.dart
├── models/
│   ├── ambiente.dart
│   └── pessoa.dart
├── screens/
│   └── home_page.dart
└── widgets/
    └── pessoa_item.dart