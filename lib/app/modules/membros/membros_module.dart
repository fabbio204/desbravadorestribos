import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/membro_controller.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MembrosModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => GoogleSheetsApi()),
    Bind.lazySingleton((i) => MembroRepository(i.get())),
    Bind.lazySingleton((i) => MembroController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const MembrosPage()),
  ];
}
