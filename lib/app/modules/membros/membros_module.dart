import 'package:desbravadores_tribos/app/modules/membros/membros_Page.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MembrosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MembrosStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MembrosPage()),
  ];
}
