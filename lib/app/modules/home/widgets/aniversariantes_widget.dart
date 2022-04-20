import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/calendario/widgets/evento_widget.dart';
import 'package:flutter/material.dart';
import 'package:desbravadores_tribos/app/core/models/aniversariante_model.dart';
import 'package:intl/intl.dart';

class AniversariantesWidget extends StatelessWidget {
  final List<AniversarianteModel> aniversariantes;
  const AniversariantesWidget({Key? key, required this.aniversariantes})
      : super(key: key);

  static final DateFormat formatadorData = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            'Aniversariantes do Mês',
            style: Theme.of(context).textTheme.headline6,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: aniversariantes.length,
              itemBuilder: (context, index) => EventoWidget(
                  evento: EventoModel(
                      dia: formatadorData.parse(aniversariantes[index].dia),
                      titulo: aniversariantes[index].nome))),
        ],
      ),
    );
  }
}
