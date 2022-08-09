import 'package:desbravadores_tribos/app/modules/calendario/cadastrar_evento_page.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import '../../../test_base.dart';

void main() {
  setUpAll(() {
    initModule(CalendarioModule());
  });

  testWidgets('Formulário vazio não pode ser cadastrado',
      (WidgetTester tester) async {
    CadastrarEventoPage page = const CadastrarEventoPage();

    await tester.pumpWidget(montarBase(page));

    Finder titulo = find.byKey(const Key('titulo'));
    expect(titulo, findsOneWidget);

    Finder descricao = find.byKey(const Key('descricao'));
    expect(descricao, findsOneWidget);

    Finder data = find.byKey(const Key('data'));
    expect(data, findsOneWidget);

    Finder salvar = find.byKey(const Key('salvar'));
    await tester.tap(salvar);
    await tester.pumpAndSettle();

    CadastrarEventoPageState state =
        tester.state(find.byType(CadastrarEventoPage));
    expect(state.formKey.currentState?.validate(), isFalse);
  });

  testWidgets('Formulário completo pode ser cadastrado',
      (WidgetTester tester) async {
    CadastrarEventoPage page = const CadastrarEventoPage();

    await tester.pumpWidget(montarBase(page));

    CadastrarEventoPageState state =
        tester.state(find.byType(CadastrarEventoPage));

    Finder titulo = find.byKey(const Key('titulo'));
    expect(titulo, findsOneWidget);
    await tester.enterText(titulo, 'Titulo 1');

    Finder descricao = find.byKey(const Key('descricao'));
    expect(descricao, findsOneWidget);
    await tester.enterText(descricao, 'Descrição 1');

    Finder data = find.byKey(const Key('data'));
    expect(data, findsOneWidget);

    await tester.tap(data);
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));

    expect(state.formKey.currentState?.validate(), isTrue);
  });
}
