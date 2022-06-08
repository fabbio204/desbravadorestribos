import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariantes_widget.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_base.dart';

main() {
  testWidgets('Testa AniversariantesWidget', (WidgetTester tester) async {
    await tester.pumpWidget(montarBase(
      SingleChildScrollView(
        child: Column(
          children: [
            AniversariantesWidget(
              key: UniqueKey(),
              aniversariantes: [
                MembroModel(nome: 'Teste 123'),
              ],
            ),
          ],
        ),
      ),
    ));

    final titleFinder = find.byKey(const Key('listaAniversariantes'));
    expect(titleFinder, findsOneWidget);
  });
}
