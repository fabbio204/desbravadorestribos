import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FinanceiroModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FinanceiroRepository()),
    Bind.lazySingleton((i) => FinanceiroController(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const FinanceiroPage()),
  ];
}
