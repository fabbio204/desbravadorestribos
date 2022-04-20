import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Setando rota inicial
    Modular.setInitialRoute(HomeModule.rotaResumo);

    return MaterialApp.router(
      title: 'Desbravadores Tribos',
      theme: ThemeData(primarySwatch: Colors.green),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
