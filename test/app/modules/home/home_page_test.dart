import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;
  setUp(() {
    initModule(HomeModule(), replaceBinds: [
      Bind.singleton((i) => ValueNotifier<String>('Início')),
    ]);
  });
  // testWidgets('Testa HomePage', (WidgetTester tester) async {
  //   await tester.pumpWidget(montarBaseComContext(const HomePage(), buildMock));

  //   Finder titulo = find.byKey(const Key('tituloAppBar'));
  //   expect(titulo, findsOneWidget);
  // });
}
