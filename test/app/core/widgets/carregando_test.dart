import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_base.dart';

void main() {
  testWidgets('Carregando', (WidgetTester tester) async {
    await tester.pumpWidget(montarBase(const Carregando()));
    await tester.pumpFrames(
        montarBase(const Carregando()), const Duration(seconds: 5));

    Finder icone = find.byKey(const Key('iconeCarregando'));
    expect(icone, findsOneWidget);
  });
}
