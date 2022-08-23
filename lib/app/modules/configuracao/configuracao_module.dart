import 'package:desbravadores_tribos/app/modules/configuracao/configuracao_Page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ConfiguracaoModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => const ConfiguracaoPage()),
  ];
}
