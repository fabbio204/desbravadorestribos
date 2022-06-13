import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_base.dart';

void main() {
  testWidgets('Testa o Log de Erro', (tester) async {
    await tester.pumpWidget(
      montarBase(
        LogErro(
          erro: Exception('Erro de testes'),
        ),
      ),
    );

    var widget = find.byKey(const Key('mensagemErro'));
    expect(widget, findsOneWidget);
  });
}
