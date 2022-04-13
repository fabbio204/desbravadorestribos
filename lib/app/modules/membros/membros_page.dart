import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_store.dart';
import 'package:flutter/material.dart';

class MembrosPage extends StatefulWidget {
  final String title;
  const MembrosPage({Key? key, this.title = 'MembrosPage'}) : super(key: key);
  @override
  MembrosPageState createState() => MembrosPageState();
}

class MembrosPageState extends State<MembrosPage> {
  final MembrosStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Membros'),
    );
  }
}
