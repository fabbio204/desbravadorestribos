import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioWidget extends StatelessWidget {
  final List<EventoModel> eventos;
  CalendarioWidget({Key? key, required this.eventos}) : super(key: key);

  final DateFormat formatador = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          EventoModel evento = eventos[index];
          String diaFormatado = formatador.format(evento.dia);
          return Card(
            child: ListTile(
              title: Text(evento.titulo),
              subtitle: Text(diaFormatado),
            ),
          );
        });
    ;
  }
}
