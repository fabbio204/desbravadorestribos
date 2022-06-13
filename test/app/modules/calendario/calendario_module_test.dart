import 'package:desbravadores_tribos/app/modules/calendario/controllers/eventos_controller.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_module.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  testWidgets('Testa CalendarioModule', (tester) async {
    final modularKey = UniqueKey();
    final modularApp = ModularApp(
      key: modularKey,
      module: CalendarioModule(),
      child: const AppWidget(),
    );
    await tester.pumpWidget(modularApp);

    final controller = Modular.get<EventoController>();
    expect(controller, isNotNull);

    final repository = Modular.get<CalendarioRepository>();
    expect(repository, isNotNull);
  });
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(Modular.initialRoute);

    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
