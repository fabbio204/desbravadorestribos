[![build](https://github.com/fabbio204/desbravadorestribos/actions/workflows/build.yml/badge.svg)](https://github.com/fabbio204/desbravadorestribos/actions/workflows/build.yml)
[![codecov](https://codecov.io/gh/fabbio204/desbravadorestribos/branch/main/graph/badge.svg?token=O6KP8XLO0C)](https://codecov.io/gh/fabbio204/desbravadorestribos)

# Desbravadores App

Aplicativo de gerenciamento local de Desbravadores

## Pacotes utilizados

- Slidy (linha de comando para estruturação do projeto)
- Triple e ValueNotifier (gerência de estado)
- Modular (estrutura do projeto em módulos e sub-módulos)

## Como rodar

Execute o comando para instalar o slidy globalmente em seu computador

> dart pub global activate slidy

## Gerando o splash screen

Pacote utilizado: [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

Caso atualize o splash screen, execute o comando para gerar novamente os arquivos

> flutter pub run flutter_native_splash:create

## Gerando o ícone do aplicativo

Pacote utilizado: [flutter_launcher_icons_maker](https://pub.dev/packages/flutter_launcher_icons_maker)

Caso atualize o ícone do aplicativo, execute o comando para gerar novamente os arquivos

> flutter pub run flutter_launcher_icons_maker:main

## Planilha modelo que o aplicativo usa para consultar os dados

O Aplicativo usa o a Api do Google Planilhas para ler e escrever os dados.

[https://docs.google.com/spreadsheets/d/1Y-ZfcBLb0yyKlLgB7x8rA1P3-6Eb2BSQ5UnitvLDqJI/edit#gid=552494114](https://docs.google.com/spreadsheets/d/1Y-ZfcBLb0yyKlLgB7x8rA1P3-6Eb2BSQ5UnitvLDqJI/edit#gid=552494114)