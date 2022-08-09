import 'package:desbravadores_tribos/app/core/widgets/membro_widget.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../../test_base.dart';

void main() {
  group('MembroWidget', () {
    testWidgets('Testa MembroWidget só com nome', (WidgetTester tester) async {
      MembroModel model = MembroModel(nome: 'Teste 1');
      await tester.pumpWidget(montarBase(MembroWidget(
        membro: model,
        key: UniqueKey(),
      )));

      Finder nome = find.byKey(const Key('nome'));
      expect(nome, findsOneWidget);

      Finder aniversario = find.byKey(const Key('aniversario'));
      expect(aniversario, findsNothing);

      Finder idade = find.byKey(const Key('idade'));
      expect(idade, findsNothing);

      Finder unidade = find.byKey(const Key('unidade'));
      expect(unidade, findsNothing);

      Finder foto = find.byKey(const Key('foto'));
      expect(foto, findsNothing);
    });

    testWidgets('Testa MembroWidget com nome e aniversário',
        (WidgetTester tester) async {
      MembroModel model =
          MembroModel(nome: 'Teste 1', aniversario: '01/01/1990');
      await tester.pumpWidget(montarBase(MembroWidget(membro: model)));

      Finder nome = find.byKey(const Key('nome'));
      expect(nome, findsOneWidget);

      Finder aniversario = find.byKey(const Key('aniversario'));
      expect(aniversario, findsOneWidget);

      Finder idade = find.byKey(const Key('idade'));
      expect(idade, findsNothing);

      Finder unidade = find.byKey(const Key('unidade'));
      expect(unidade, findsNothing);

      Finder foto = find.byKey(const Key('foto'));
      expect(foto, findsNothing);
    });
    testWidgets('Testa MembroWidget com nome, aniversário e idade',
        (WidgetTester tester) async {
      MembroModel model =
          MembroModel(nome: 'Teste 1', aniversario: '01/01/1990', idade: 20);
      await tester.pumpWidget(montarBase(MembroWidget(membro: model)));

      Finder nome = find.byKey(const Key('nome'));
      expect(nome, findsOneWidget);

      Finder aniversario = find.byKey(const Key('aniversario'));
      expect(aniversario, findsOneWidget);

      Finder idade = find.byKey(const Key('idade'));
      expect(idade, findsOneWidget);

      Finder unidade = find.byKey(const Key('unidade'));
      expect(unidade, findsNothing);

      Finder foto = find.byKey(const Key('foto'));
      expect(foto, findsNothing);
    });

    testWidgets('Testa MembroWidget com nome, aniversário, idade e unidade',
        (WidgetTester tester) async {
      MembroModel model = MembroModel(
          nome: 'Teste 1',
          aniversario: '01/01/2022',
          idade: 20,
          unidade: 'Tribos');
      await tester.pumpWidget(montarBase(MembroWidget(membro: model)));

      Finder nome = find.byKey(const Key('nome'));
      expect(nome, findsOneWidget);

      Finder aniversario = find.byKey(const Key('aniversario'));
      expect(aniversario, findsOneWidget);

      Finder idade = find.byKey(const Key('idade'));
      expect(idade, findsOneWidget);

      Finder unidade = find.byKey(const Key('unidade'));
      expect(unidade, findsOneWidget);

      Finder foto = find.byKey(const Key('foto'));
      expect(foto, findsNothing);
    });

    testWidgets(
        'Testa MembroWidget com nome, aniversário, idade, unidade e foto',
        (WidgetTester tester) async {
      MembroModel model = MembroModel(
          nome: 'Teste 1',
          aniversario: '01/01/2022',
          idade: 20,
          unidade: 'Tribos',
          foto: 'https://via.placeholder.com/150');

      await tester.pumpWidget(montarBase(MembroWidget(
        membro: model,
      )));

      await tester.pumpFrames(
          montarBase(MembroWidget(
            membro: model,
          )),
          const Duration(seconds: 1));

      Finder nome = find.byKey(const Key('nome'));
      expect(nome, findsOneWidget);

      Finder aniversario = find.byKey(const Key('aniversario'));
      expect(aniversario, findsOneWidget);

      Finder idade = find.byKey(const Key('idade'));
      expect(idade, findsOneWidget);

      Finder unidade = find.byKey(const Key('unidade'));
      expect(unidade, findsOneWidget);

      Finder foto = find.byKey(const Key('foto'));
      expect(foto, findsOneWidget);
    });

    testWidgets(
        'Membro que faz aniversário hoje deveria ser exibido em amarelo',
        (WidgetTester tester) async {
      DateTime hoje = DateTime.now();

      DateFormat formataData = DateFormat('dd/MM/yyyy');

      MembroModel model = MembroModel(
          nome: 'Teste 1',
          aniversario: formataData.format(hoje),
          idade: 20,
          unidade: 'Tribos',
          foto: 'https://via.placeholder.com/150');

      await tester.pumpWidget(montarBase(MembroWidget(
        membro: model,
      )));

      Finder container = find.byKey(const Key('cardMembroWidget'));
      expect(container, isNotNull);
      expect(container, findsOneWidget);
      Container widget = container.evaluate().first.widget as Container;
      expect(widget.color, Colors.yellow.shade200);
    });
  });
}
