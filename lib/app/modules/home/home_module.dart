import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_module.dart';
import 'package:desbravadores_tribos/app/modules/configuracao/configuracao_module.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_module.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/inicio_page.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends Module {
  static String rotaCheckBiometria = '/biometria/';
  static String rotaResumo = '/inicio/';
  static String rotaCalendario = '/calendario/';
  static String rotaMembros = '/membros/';
  static String rotaFinanceiro = '/financeiro/';
  static String rotaConfiguracoes = '/configuracoes/';

  // Configura a injeção de dependência do módulo
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => ValueNotifier<String>('Início')),
    Bind.singleton((i) => ValueNotifier<List<Widget>?>([])),
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton((i) => HomeController(i.get<HomeRepository>())),
    Bind.lazySingleton((i) => GoogleSheetsApi()),
    Bind.lazySingleton((i) => HomeRepository(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const HomePage(),
      children: [
        ChildRoute(rotaResumo, child: (_, args) => const InicioPage()),
        ModuleRoute(rotaCalendario, module: CalendarioModule()),
        ModuleRoute(rotaMembros, module: MembrosModule()),
        ModuleRoute(rotaFinanceiro, module: FinanceiroModule()),
        ModuleRoute(rotaConfiguracoes, module: ConfiguracaoModule()),
      ],
      transition: TransitionType.noTransition,
    ),
  ];
}
