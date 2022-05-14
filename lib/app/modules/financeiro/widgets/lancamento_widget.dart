import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:flutter/material.dart';

class LancamentoWidget extends StatelessWidget {
  final LancamentoModel model;
  const LancamentoWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icone(),
              Expanded(
                child: Text(model.descricao),
                flex: 5,
              ),
              Expanded(
                child: Text(model.data),
                flex: 2,
              ),
            ],
          ),
          if (model.entrada != null && model.entrada!.isNotEmpty)
            Text(model.entrada.toString()),
          if (model.saida != null && model.saida!.isNotEmpty)
            Text("-" + model.saida.toString()),
          if (model.envolvido != null) Text(model.envolvido.toString()),
        ],
      ),
    );
  }

  Widget icone() {
    if (model.entrada != null && model.entrada!.isNotEmpty) {
      return Icon(
        Icons.add,
        color: Colors.green[600],
      );
    }

    return Icon(Icons.remove, color: Colors.red[600]);
  }
}
