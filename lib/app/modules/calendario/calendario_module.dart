import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/controllers/eventos_controller.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CalendarioModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => GoogleSheetsApi()),
    Bind.lazySingleton((i) => CalendarioRepository(i.get())),
    Bind.lazySingleton((i) => EventoController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const CalendarioPage()),
  ];
}
