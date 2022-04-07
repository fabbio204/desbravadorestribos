import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  // Configura a injeção de dependência do módulo
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeController(i.get<HomeRepository>())),
    Bind.lazySingleton((i) => HomeRepository()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
  ];
}
