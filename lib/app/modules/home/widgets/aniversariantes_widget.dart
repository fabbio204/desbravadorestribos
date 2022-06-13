import 'package:desbravadores_tribos/app/core/widgets/membro_widget.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter/material.dart';

class AniversariantesWidget extends StatelessWidget {
  final List<MembroModel> aniversariantes;
  const AniversariantesWidget({Key? key, required this.aniversariantes})
      : super(key: key);

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
            key: const Key('listaAniversariantes'),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: aniversariantes.length,
            itemBuilder: (context, index) => MembroWidget(
                membro: aniversariantes[index], ocultarIcone: true),
          ),
        ],
      ),
    );
  }
}
