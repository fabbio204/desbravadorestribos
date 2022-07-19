import 'package:desbravadores_tribos/app/modules/calendario/cadastrar_evento_page.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/cadastrar_lancamento_page.dart';
import 'package:desbravadores_tribos/app/core/pages/membro_detalhes.dart';
import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/controllers/cadastrar_lancamento_store.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/controllers/membro_detalhes_controller.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  static String rotaCadastrarEvento = "/cadastrar-evento/";
  static String rotaCadastrarLancamento = "/cadastrar-lancamento/";

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => Dio()),
    Bind.lazySingleton((i) => GoogleSheetsApi()),
    Bind.lazySingleton((i) => CadastrarLancamentoStore(i.get())),
    Bind.lazySingleton((i) => FinanceiroRepository(i.get())),
    Bind.lazySingleton((i) => CalendarioRepository(i.get())),
    Bind.lazySingleton((i) => HomeRepository(i.get(), i.get())),
    Bind.lazySingleton((i) => MembroRepository(i.get())),
    Bind.lazySingleton((i) => MembroDetalhesController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ChildRoute(
      '/detalhes-membro/',
      child: (_, args) => MembroDetalhes(
        membro: args.data,
      ),
    ),
    ChildRoute(rotaCadastrarEvento,
        child: (_, args) => const CadastrarEventoPage()),
    ChildRoute(rotaCadastrarLancamento,
        child: (_, args) => const CadastrarLancamentoPage()),
  ];
}
