import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:flutter/material.dart';

class LancamentoWidget extends StatelessWidget {
  final LancamentoModel model;
  const LancamentoWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(model.data),
        Text(model.descricao),
        if (model.entrada != null) Text(model.entrada.toString()),
        if (model.saida != null) Text(model.saida.toString()),
        if (model.envolvido != null) Text(model.envolvido.toString()),
      ],
    );
  }
}
