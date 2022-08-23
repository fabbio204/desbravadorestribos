import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuLateralWidget extends StatefulWidget {
  const MenuLateralWidget({Key? key}) : super(key: key);

  @override
  State<MenuLateralWidget> createState() => _MenuLateralWidgetState();
}

class _MenuLateralWidgetState extends State<MenuLateralWidget> {
  void _fecharDrawer() {
    Navigator.pop(context);
  }

  void abrirTela(Tela tela) {
    switch (tela) {
      case Tela.inicio:
        Modular.to.navigate(HomeModule.rotaResumo);
        Modular.get<ValueNotifier<String>>().value = 'Início';
        Modular.get<ValueNotifier<List<Widget>?>>().value = [];
        break;

      case Tela.calendario:
        Modular.to.navigate(HomeModule.rotaCalendario);
        Modular.get<ValueNotifier<String>>().value = 'Calendário';
        Modular.get<ValueNotifier<List<Widget>?>>().value = [];
        break;

      case Tela.membros:
        Modular.to.navigate(HomeModule.rotaMembros);
        Modular.get<ValueNotifier<String>>().value = 'Membros';
        Modular.get<ValueNotifier<List<Widget>?>>().value = [];
        break;

      case Tela.financeiro:
        Modular.to.navigate(HomeModule.rotaFinanceiro);
        Modular.get<ValueNotifier<String>>().value = 'Financeiro';
        Modular.get<ValueNotifier<List<Widget>?>>().value = [];
        break;

      case Tela.configuracoes:
        Modular.to.navigate(HomeModule.rotaConfiguracoes);
        Modular.get<ValueNotifier<String>>().value = 'Configurações';
        Modular.get<ValueNotifier<List<Widget>?>>().value = [];
        break;
    }

    _fecharDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const Key('drawerMenu'),
      elevation: 5,
      child: ListView(
        key: const Key('listaItensMenu'),
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              decoration: BoxDecoration(color: context.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50,
                    child: Image.asset('splash.png'),
                  ),
                  const Text(
                    'Clube Tribos',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            key: const Key('botaoInicio'),
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () => abrirTela(Tela.inicio),
          ),
          ListTile(
            key: const Key('botaoCalendario'),
            leading: const Icon(Icons.calendar_month),
            title: const Text('Calendário'),
            onTap: () => abrirTela(Tela.calendario),
          ),
          ListTile(
            key: const Key('botaoMembros'),
            leading: const Icon(Icons.group),
            title: const Text('Membros'),
            onTap: () => abrirTela(Tela.membros),
          ),
          ListTile(
            key: const Key('botaoFinanceiro'),
            leading: const Icon(Icons.monetization_on),
            title: const Text('Financeiro'),
            onTap: () => abrirTela(Tela.financeiro),
          ),
          ListTile(
            key: const Key('botaoConfiguracoes'),
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () => abrirTela(Tela.configuracoes),
          ),
        ],
      ),
    );
  }
}

enum Tela { inicio, calendario, membros, financeiro, configuracoes }
