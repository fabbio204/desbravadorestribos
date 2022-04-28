[![Flutter](https://github.com/fabbio204/desbravadorestribos/actions/workflows/build.yml/badge.svg)](https://github.com/fabbio204/desbravadorestribos/actions/workflows/build.yml)

# Tribos App

Aplicativo do Clube de Desbravadores Tribos

## Pacotes utilizados

- Slidy (linha de comando para estruturação do projeto)
- Mobx (gerência de estado)
- Modular (estrutura do projeto)

## Como rodar

Execute o comando para instalar o slidy globalmente em seu computador

> dart pub global activate slidy

Qual alterar os actions e observer do Mobx (classes _store.dart) use o comando para gerar os arquivos do mobx

> slidy run mobx

## Gerando o splash screen

Pacote utilizado: [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

Caso de atualize o splash screen, execute o comando para gerar novamente os arquivos

> flutter pub run flutter_native_splash:create