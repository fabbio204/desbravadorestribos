import 'package:desbravadores_tribos/app/core/storage/hive_config.dart';
import 'package:flutter/material.dart';

class ConfiguracaoPage extends StatefulWidget {
  const ConfiguracaoPage({Key? key}) : super(key: key);
  @override
  ConfiguracaoPageState createState() => ConfiguracaoPageState();
}

class ConfiguracaoPageState extends State<ConfiguracaoPage> {
  static String impressaoDigital = "impressaoDigital";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        buildSwitch(
          'Login com impressão digital',
          Icons.fingerprint,
          HiveConfig.get(impressaoDigital),
          (checkado) async {
            setState(() {
              HiveConfig.set(impressaoDigital, checkado);
            });
          },
        )
      ]),
    );
  }

  Widget buildSwitch(String titulo, IconData icone, bool valor,
      Future<void> Function(bool checkado) onChange) {
    return GestureDetector(
      onTap: () {
        onChange.call(!valor);
      },
      child: ListTile(
        leading: Icon(icone, color: Colors.green),
        title: Text(titulo),
        trailing: Switch(
          value: valor,
          onChanged: onChange,
        ),
      ),
    );
  }
}
