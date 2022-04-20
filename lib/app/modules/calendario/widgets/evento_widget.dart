import 'package:flutter/material.dart';

import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:intl/intl.dart';

class EventoWidget extends StatelessWidget {
  final EventoModel evento;
  static final DateFormat formataData = DateFormat('dd/MM');
  const EventoWidget({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(formataData.format(evento.dia)),
        title: Text(evento.titulo),
      ),
    );
  }
}
