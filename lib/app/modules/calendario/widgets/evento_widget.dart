import 'package:flutter/material.dart';

import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:intl/intl.dart';

class EventoWidget extends StatelessWidget {
  final EventoModel evento;
  static final DateFormat formataData = DateFormat('dd/MM');
  const EventoWidget({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green[50],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 40,
                width: 40,
                child: Center(
                  child: Text(
                    formataData.format(evento.dia),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, top: 8, right: 8, bottom: 8),
            child: Text(evento.titulo),
          ),
        )
      ],
    );
  }
}
