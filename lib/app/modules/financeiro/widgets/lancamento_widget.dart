import 'package:desbravadores_tribos/app/app_module.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/cadastrar_lancamento_page.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
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
  FinanceiroRepository repository = Modular.get();

  static double fonteValor = 12.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 0),
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
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      widget.model.data,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                if (widget.model.entrada != null &&
                    widget.model.entrada!.isNotEmpty)
                  Text(
                    widget.model.entrada.toString(),
                    key: const Key('labelEntrada'),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: fonteValor,
                    ),
                  ),
                if (widget.model.saida != null &&
                    widget.model.saida!.isNotEmpty)
                  Text(
                    "-" + widget.model.saida.toString(),
                    key: const Key('labelSaida'),
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: fonteValor,
                    ),
                  ),
                if (widget.model.envolvido != null)
                  Text(
                    widget.model.envolvido.toString(),
                    key: const Key('labelEnvolvido'),
                    style: TextStyle(
                        color: Colors.grey[700], fontSize: fonteValor),
                  ),
              ],
            ),
          ),
          PopupMenuButton<int>(
            padding:
                const EdgeInsets.only(right: 2, top: 2, left: 4, bottom: 2),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: LancamentoWidgetOpcoes.editar.id,
                child: const Text('Editar'),
              ),
              PopupMenuItem<int>(
                value: LancamentoWidgetOpcoes.excluir.id,
                child: const Text('Excluir'),
              ),
            ],
            onSelected: (int value) {
              if (value == LancamentoWidgetOpcoes.editar.id) {
                editarLancamento();
              } else if (value == LancamentoWidgetOpcoes.excluir.id) {
                excluirLancamento();
              }
            },
          )
        ],
      ),
    );
  }

  Future<void> editarLancamento() async {
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

  void excluirLancamento() {
    ValueNotifier<bool> excluindo = ValueNotifier(false);
    showDialog(
      context: context,
      builder: (context) {
        Widget cancelar = TextButton(
          child: const Text("Cancelar"),
          onPressed: () {
            // Fecha o dialog
            Navigator.of(context).pop();
          },
        );

        Widget excluir = TextButton(
          child: ValueListenableBuilder<bool>(
            valueListenable: excluindo,
            builder: (context, value, child) {
              if (value) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Excluir");
              }
            },
          ),
          onPressed: () {
            repository.excluirLancamento(widget.model.id!).then((value) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Excluído com sucesso'),
                ),
              );
              controller.init();
              excluindo.value = false;
            });
            excluindo.value = true;
          },
        );

        return AlertDialog(
          title: const Text('Excluir Lançamento'),
          content: const Text('Tem certeza que deseja excluir?'),
          actions: [cancelar, excluir],
        );
      },
    );
  }
}

enum LancamentoWidgetOpcoes {
  editar(id: 1),
  excluir(id: 2);

  const LancamentoWidgetOpcoes({required this.id});
  final int id;
}
