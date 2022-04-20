import 'package:desbravadores_tribos/app/modules/calendario/calendario_module.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_module.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/inicio_page.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends Module {
  static String rotaResumo = '/inicio';
  static String rotaCalendario = '/calendario/';
  static String rotaMembros = '/membros';
  static String rotaFinanceiro = '/financeiro/';

  // Configura a injeção de dependência do módulo
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(i.get<HomeRepository>())),
    Bind.lazySingleton((i) => HomeRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const HomePage(),
        children: [
          ChildRoute(rotaResumo, child: (_, args) => const InicioPage()),
          ModuleRoute(rotaCalendario, module: CalendarioModule()),
          ModuleRoute(rotaMembros, module: MembrosModule()),
          ModuleRoute(rotaFinanceiro, module: FinanceiroModule()),
        ]),
  ];
}
