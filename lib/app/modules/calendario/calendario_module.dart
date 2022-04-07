import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_Page.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CalendarioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CalendarioRepository()),
    Bind.lazySingleton((i) => CalendarioStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CalendarioPage()),
  ];
}
