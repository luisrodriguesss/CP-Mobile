# Gym Capacity 2.0 — Controle de Lotação da Academia

Projeto desenvolvido para o Checkpoint 02 de Mobile Application Development. Aplicativo em Flutter/Dart para cadastrar pessoas e gerenciar entradas e saídas de uma academia com capacidade máxima de 50 pessoas.

## Integrantes

- Luis Fillipe Seripieri - RM567918
- Paulo Henrique Kian - RM563343

## Ambiente escolhido

Academia, com capacidade máxima de 50 pessoas.

## Vídeo de demonstração

[Assistir à demonstração do aplicativo](https://youtu.be/3SCgNGQLbWk)

## Funcionalidades e regras

- Cadastro com nome e matrícula/identificação usando `TextField` e `TextEditingController`.
- Registro automático de data e hora de entrada.
- Listagem com `ListView.builder`, identificação, horários e situação de cada pessoa.
- Contador de pessoas presentes e bloqueio de novas entradas quando a lotação chega a 50.
- Validação de campos obrigatórios e de identificação duplicada entre pessoas presentes.
- Registro de saída, com atualização da situação, horário e lotação.
- Bloqueio de uma segunda saída para a mesma pessoa.
- Deslizamento lateral com ações funcionais de **SAÍDA** e **EXCLUIR**.
- Confirmação com `AlertDialog` e mensagens com `ScaffoldMessenger` e `SnackBar`.
- Widget personalizado `PessoaItem`, que recebe um objeto `Pessoa` e funções por parâmetro.
- Interface personalizada para academia com Google Fonts.
- Ícone personalizado para Android e iOS, configurado com `flutter_launcher_icons`.

Os registros ficam na memória durante a execução. Reiniciar o aplicativo ou recarregar a página inicia uma lista vazia.

## Tecnologias e pacotes

| Tecnologia/pacote | Uso |
| --- | --- |
| Flutter / Dart | Interface e lógica do aplicativo |
| `intl` (`^0.20.3`) | Formatação de datas e horários |
| `google_fonts` (`^8.2.1`) | Tipografia Poppins |
| `flutter_slidable` (`^4.0.3`) | Ações ao deslizar os registros |
| `flutter_launcher_icons` (`^0.14.4`) | Geração do ícone do aplicativo |
| `cupertino_icons` (`^1.0.8`) | Pacote de ícones incluído no projeto |

O `pubspec.yaml` exige Dart `>=3.11.5 <4.0.0`. Instale uma versão estável do Flutter que inclua um Dart compatível.

## Como executar

Pré-requisitos: Git, Flutter SDK e Chrome ou um dispositivo/emulador Android. VS Code com as extensões Flutter e Dart facilita a abertura do código. Para Android, configure também o Android SDK, por exemplo com Android Studio.

Ambiente utilizado na execução: Windows 10, Flutter 3.47.7, Dart 3.13.5, JDK 17 e emulador Android 17 (API 37).

Clone e entre na pasta que contém o `pubspec.yaml`:

```bash
git clone https://github.com/luisrodriguesss/CP-Mobile.git
cd CP-Mobile/controle_lotacao_academia
flutter pub get
```

Para executar no Chrome:

```bash
flutter run -d chrome
```

Para Android, inicie o emulador ou conecte o aparelho com depuração USB habilitada. Confira os dispositivos e execute:

```bash
flutter devices
flutter run
```

Se aparecer uma lista, escolha o dispositivo Android. Para encerrar, pressione `q` no terminal.

Os ícones nativos estão incluídos no repositório. Para regenerá-los, se necessário, execute na pasta `controle_lotacao_academia`:

```bash
dart run flutter_launcher_icons
```

## Organização do código

| Arquivo | Responsabilidade |
| --- | --- |
| `controle_lotacao_academia/lib/main.dart` | Inicialização, tema e Google Fonts |
| `controle_lotacao_academia/lib/models/pessoa.dart` | Pessoa, horários e situação |
| `controle_lotacao_academia/lib/screens/home_page.dart` | Cadastro, validações, contador e lista |
| `controle_lotacao_academia/lib/widgets/pessoa_item.dart` | Item personalizado, Slidable, confirmações e callbacks |
| `controle_lotacao_academia/lib/models/ambiente.dart` | Modelo do ambiente mantido do Checkpoint 01 |
| `controle_lotacao_academia/pubspec.yaml` | Dependências, imagem e configuração dos ícones |

Na versão 2.0, a lotação é calculada a partir da lista em `HomePage`. O modelo `Ambiente` do Checkpoint 01 não controla essa tela.

## Documentação oficial

- [Instalação do Flutter com VS Code](https://docs.flutter.dev/install/with-vs-code)
- [Configuração para Android](https://docs.flutter.dev/platform-integration/android/setup)
- [Execução no navegador](https://docs.flutter.dev/platform-integration/web/building)
