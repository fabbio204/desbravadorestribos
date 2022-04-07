import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_store.dart';
import 'package:flutter/material.dart';

class CalendarioPage extends StatefulWidget {
  final String title;
  const CalendarioPage({Key? key, this.title = 'CalendarioPage'}) : super(key: key);
  @override
  CalendarioPageState createState() => CalendarioPageState();
}
class CalendarioPageState extends State<CalendarioPage> {
  final CalendarioStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}