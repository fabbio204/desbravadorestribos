import 'package:desbravadores_tribos/app/app_module.dart';
import 'package:desbravadores_tribos/app/modules/calendario/cadastrar_evento_page.dart';
import 'package:desbravadores_tribos/app/modules/calendario/controllers/eventos_controller.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter/material.dart';

import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

enum EventoWidgetAcoes {
  editar(id: 1),
  excluir(id: 2);

  const EventoWidgetAcoes({required this.id});

  final int id;
}

class EventoWidget extends StatefulWidget {
  final EventoModel evento;
  static final DateFormat formataData = DateFormat('dd/MM');
  final bool exibirMenuAcoes;
  const EventoWidget(
      {Key? key, required this.evento, this.exibirMenuAcoes = false})
      : super(key: key);

  @override
  State<EventoWidget> createState() => _EventoWidgetState();
}

class _EventoWidgetState extends State<EventoWidget> {
  late CalendarioRepository repository;
  late EventoController controller;

  @override
  void initState() {
    if (widget.exibirMenuAcoes) {
      repository = Modular.get();
      controller = Modular.get();
    }

    super.initState();
  }

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
                    EventoWidget.formataData.format(widget.evento.dia),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.evento.titulo),
                if (widget.evento.descricao != null &&
                    widget.evento.descricao!.isNotEmpty)
                  Text(
                    widget.evento.descricao!,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
              ],
            ),
          ),
        ),
        if (widget.exibirMenuAcoes &&
            widget.evento.id != null &&
            widget.evento.id!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  value: EventoWidgetAcoes.editar.id,
                  child: const Text(
                    "Editar",
                  ),
                ),
                PopupMenuItem<int>(
                  value: EventoWidgetAcoes.excluir.id,
                  child: const Text(
                    "Excluir",
                  ),
                ),
              ],
              onSelected: (item) {
                if (item == EventoWidgetAcoes.editar.id) {
                  editarEvento();
                } else if (item == EventoWidgetAcoes.excluir.id) {
                  excluirEvento();
                }
              },
            ),
          ),
      ],
    );
  }

  void editarEvento() async {
    CadastrarEventoPageArgs args = CadastrarEventoPageArgs(
        id: widget.evento.id,
        data: widget.evento.dia,
        texto: widget.evento.titulo,
        descricao: widget.evento.descricao,
        editar: true);

    bool? atualizar = await Modular.to.pushNamed<bool>(
      AppModule.rotaCadastrarEvento,
      arguments: args,
    );

    if (atualizar != null && atualizar) {
      controller.init();
    }
  }

  void excluirEvento() {
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
            repository.excluirEvento(widget.evento.id!).then((value) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Excluido com sucesso'),
                ),
              );
              controller.init();
              excluindo.value = false;
            });
            excluindo.value = true;
          },
        );

        return AlertDialog(
          title: const Text('Excluir Evento'),
          content: const Text('Tem certeza que deseja excluir?'),
          actions: [cancelar, excluir],
        );
      },
    );
  }
}
