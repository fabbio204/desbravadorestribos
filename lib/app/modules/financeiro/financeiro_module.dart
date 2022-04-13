import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_Page.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FinanceiroModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FinanceiroStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => FinanceiroPage()),
  ];
}
