import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/calendario/widgets/evento_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProximosEventosWidget extends StatelessWidget {
  final List<EventoModel> eventos;
  ProximosEventosWidget({Key? key, required this.eventos}) : super(key: key);

  final DateFormat formatador = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Text(
            'Próximos Eventos',
            key: const Key('tituloEventos'),
            style: Theme.of(context).textTheme.headline6,
          ),
          ListView.builder(
            key: const Key('listaEventos'),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              EventoModel evento = eventos[index];
              return EventoWidget(evento: evento);
            },
          ),
        ],
      ),
    );
  }
}
