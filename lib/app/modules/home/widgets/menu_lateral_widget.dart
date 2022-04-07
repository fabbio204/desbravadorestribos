import 'package:flutter/material.dart';

class MenuLateralWidget extends StatefulWidget {
  const MenuLateralWidget({Key? key}) : super(key: key);

  @override
  State<MenuLateralWidget> createState() => _MenuLateralWidgetState();
}

class _MenuLateralWidgetState extends State<MenuLateralWidget> {
  void _fecharDrawer() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: ListView(
        children: [
          ListTile(
            leading: const Text('Aniversariantes'),
            onTap: () {
              _fecharDrawer();
            },
          ),
          ListTile(
            leading: const Text('Calendário'),
            onTap: () {
              _fecharDrawer();
            },
          ),
          ListTile(
            leading: const Text('Membros'),
            onTap: () {
              _fecharDrawer();
            },
          ),
          ListTile(
            leading: const Text('Financeiro'),
            onTap: () {
              _fecharDrawer();
            },
          ),
        ],
      ),
    );
  }
}
