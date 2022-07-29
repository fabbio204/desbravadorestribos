import 'package:desbravadores_tribos/app/app_module.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/cadastrar_lancamento_page.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LancamentoWidget extends StatefulWidget {
  final LancamentoModel model;
  const LancamentoWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<LancamentoWidget> createState() => _LancamentoWidgetState();
}

class _LancamentoWidgetState extends State<LancamentoWidget> {
  FinanceiroController controller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.model.descricao,
                        style: const TextStyle(fontSize: 16),
                      ),
                      flex: 5,
                    ),
                    Text(widget.model.data),
                  ],
                ),
                if (widget.model.entrada != null &&
                    widget.model.entrada!.isNotEmpty)
                  Text(widget.model.entrada.toString(),
                      key: const Key('labelEntrada')),
                if (widget.model.saida != null &&
                    widget.model.saida!.isNotEmpty)
                  Text("-" + widget.model.saida.toString(),
                      key: const Key('labelSaida')),
                if (widget.model.envolvido != null)
                  Text(widget.model.envolvido.toString(),
                      key: const Key('labelEnvolvido')),
              ],
            ),
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: LancamentoWidgetOpcoes.editar.id,
                child: const Text('Editar'),
              )
            ],
            onSelected: (int value) async {
              if (value == LancamentoWidgetOpcoes.editar.id) {
                var args = CadastrarLancamentoArgumentos(
                  id: widget.model.id,
                  nome: widget.model.envolvido,
                  entrada: widget.model.entrada,
                  saida: widget.model.saida,
                  descricao: widget.model.descricao,
                  caixa: widget.model.subCaixa,
                  data: widget.model.data,
                  editar: true,
                );

                bool? atualizar = await Modular.to.pushNamed<bool>(
                  AppModule.rotaCadastrarLancamento,
                  arguments: args,
                );

                if (atualizar != null && atualizar) {
                  controller.init();
                }
              }
            },
          )
        ],
      ),
    );
  }
}

enum LancamentoWidgetOpcoes {
  editar(id: 1);

  const LancamentoWidgetOpcoes({required this.id});
  final int id;
}
