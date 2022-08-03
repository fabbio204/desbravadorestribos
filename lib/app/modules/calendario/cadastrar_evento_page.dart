import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';

import 'package:desbravadores_tribos/app/modules/calendario/controllers/cadastrar_evento_store.dart';

class CadastrarEventoPageArgs {
  String? id;
  String? texto;
  DateTime? data;
  String? descricao;
  bool? editar;
  CadastrarEventoPageArgs({
    this.id,
    this.texto,
    this.data,
    this.descricao,
    this.editar,
  });
}

class CadastrarEventoPage extends StatefulWidget {
  final CadastrarEventoPageArgs? args;
  const CadastrarEventoPage({Key? key, this.args}) : super(key: key);

  @override
  State<CadastrarEventoPage> createState() => _CadastrarEventoPageState();
}

class _CadastrarEventoPageState extends State<CadastrarEventoPage> {
  static GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController dataController = TextEditingController();
  CadastrarEventoController controller = Modular.get();

  late ValueNotifier<String> texto;
  late ValueNotifier<String> descricao;
  late ValueNotifier<DateTime> data;
  late String titulo;

  @override
  void initState() {
    controller.observer(
      onState: (state) {
        if (state) {
          bool recarregarTela = true;
          Navigator.pop(context, recarregarTela);
        }
      },
    );

    data = ValueNotifier(widget.args?.data ?? DateTime.now());
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    dataController.text = formatter.format(data.value);

    texto = ValueNotifier(widget.args?.texto ?? '');
    descricao = ValueNotifier(widget.args?.descricao ?? '');

    titulo = widget.args?.editar == true ? 'Editar evento' : 'Cadastrar evento';

    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<CadastrarEventoController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(titulo),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 1,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: texto.value,
                      onChanged: (value) => texto.value = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 3,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: descricao.value,
                      onChanged: (value) => descricao.value = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onTap: _abrirDatePicker,
                      readOnly: true,
                      controller: dataController,
                      decoration: const InputDecoration(
                        labelText: 'Data',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }

                        return null;
                      },
                    ),
                  ),
                  ScopedBuilder<CadastrarEventoController, Exception, bool>(
                    store: controller,
                    onError: (context, error) => Text(error.toString()),
                    onLoading: (context) => const CircularProgressIndicator(),
                    onState: (_, bool retorno) {
                      return ElevatedButton(
                        onPressed: () async {
                          bool? valido = formKey.currentState?.validate();
                          if (valido != null && valido) {
                            if (widget.args?.editar != null &&
                                widget.args?.editar == true &&
                                widget.args?.id != null &&
                                widget.args!.id!.isNotEmpty) {
                              controller.editar(widget.args?.id, texto.value,
                                  descricao.value, data.value);
                            } else {
                              controller.salvar(
                                  texto.value, descricao.value, data.value);
                            }
                          }
                        },
                        child: const Text('Salvar'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _abrirDatePicker() async {
    DateTime hoje = DateTime.now();
    DateTime inicioDoAno = DateTime(hoje.year, 1, 1);
    DateTime anoQueVem = DateTime(hoje.year + 1, 12, 31);
    final DateTime? dataSelecionada = await showDatePicker(
        context: context,
        initialDate: data.value,
        firstDate: inicioDoAno,
        lastDate: anoQueVem);

    if (dataSelecionada != null) {
      data.value = dataSelecionada;
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      dataController.text = formatter.format(dataSelecionada);
    }
  }
}
