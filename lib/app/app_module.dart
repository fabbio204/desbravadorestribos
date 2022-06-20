import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton((i) => GoogleSheetsApi()),
    Bind.lazySingleton((i) => CalendarioRepository(i.get())),
    Bind.lazySingleton((i) => HomeRepository(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
