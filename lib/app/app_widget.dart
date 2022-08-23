import 'package:desbravadores_tribos/app/core/storage/hive_config.dart';
import 'package:desbravadores_tribos/app/modules/configuracao/configuracao_page.dart';
import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Setando rota inicial
    bool usarImpressaoDigital = HiveConfig.get<bool>(
        ConfiguracaoPageState.impressaoDigital,
        valorPadrao: true);
    if (usarImpressaoDigital) {
      Modular.setInitialRoute(HomeModule.rotaCheckBiometria);
    } else {
      Modular.setInitialRoute(HomeModule.rotaResumo);
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Desbravadores Tribos',
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: Colors.grey[200],
        secondaryHeaderColor: Colors.greenAccent,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
