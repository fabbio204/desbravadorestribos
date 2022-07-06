import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../../../test_base.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

main() {
  final navigate = ModularNavigateMock();
  BuildContext buildMock = BuildContextMock();
  Modular.navigatorDelegate = navigate;

  setUp(() {
    initModule(HomeModule(), replaceBinds: []);
  });

  testWidgets('Testa MenuLateralWidget', (WidgetTester tester) async {
    when(() => navigate.navigate(HomeModule.rotaResumo))
        .thenAnswer((_) async => true);

    when(() => navigate.navigate(HomeModule.rotaCalendario))
        .thenAnswer((_) async => true);

    when(() => navigate.navigate(HomeModule.rotaMembros))
        .thenAnswer((_) async => true);

    when(() => navigate.navigate(HomeModule.rotaFinanceiro))
        .thenAnswer((_) async => true);

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    await tester.pumpWidget(
      montarBaseComContext(
        Scaffold(
          key: scaffoldKey,
          body: const SizedBox(
            height: 1000,
            width: 500,
          ),
          drawer: const SingleChildScrollView(
            child: SizedBox(
              height: 1000,
              width: 500,
              child: MenuLateralWidget(),
            ),
          ),
        ),
        buildMock,
      ),
    );

    // Abre o Drawer com movimento
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), const Offset(300, 0));
    await tester.pumpAndSettle();

    Finder lista = find.byKey(const Key('listaItensMenu'));
    expect(lista, findsOneWidget);

    await tester.pumpAndSettle();

    Finder botaoInicio = find.byKey(const Key('botaoInicio'));
    await tester.tap(botaoInicio);

    scaffoldKey.currentState?.openEndDrawer();
    await tester.pump(const Duration(seconds: 1));

    Finder botaoCalendario = find.byKey(const Key('botaoCalendario'));
    await tester.tap(botaoCalendario);

    scaffoldKey.currentState?.openDrawer();
    await tester.pump(const Duration(seconds: 1));

    Finder botaoMembros = find.byKey(const Key('botaoMembros'));
    await tester.tap(botaoMembros);

    scaffoldKey.currentState?.openDrawer();
    await tester.pump(const Duration(seconds: 1));

    Finder botaoFinanceiro = find.byKey(const Key('botaoFinanceiro'));
    await tester.tap(botaoFinanceiro);

    scaffoldKey.currentState?.openDrawer();
    await tester.pump(const Duration(seconds: 1));
  });
}
