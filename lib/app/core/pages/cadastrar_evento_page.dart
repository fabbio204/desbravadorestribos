import 'package:desbravadores_tribos/app/modules/calendario/controllers/cadastrar_evento_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';

class CadastrarEventoPage extends StatefulWidget {
  const CadastrarEventoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarEventoPage> createState() => _CadastrarEventoPageState();
}

class _CadastrarEventoPageState
    extends ModularState<CadastrarEventoPage, CadastrarEventoController> {
  static GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController dataController = TextEditingController();

  ValueNotifier<String> texto = ValueNotifier('');
  ValueNotifier<DateTime> data = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Evento'),
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
                      maxLines: 3,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
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
                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            bool? valido = formKey.currentState?.validate();
                            if (valido != null && valido) {
                              await controller.salvar(texto.value, data.value);
                              if(controller.state) {
                                Navigator.pop(context);
                              }                              
                            }
                          },
                    child: const Text('Salvar'),
                  ),
                  ScopedBuilder<CadastrarEventoController, Exception, bool>(
                    store: store,
                    onError: (context, error) => Text(error.toString()),
                    onLoading: (context) => const CircularProgressIndicator(),
                    onState: (_, bool retorno) {
                      return Container();
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
        initialDate: hoje,
        firstDate: inicioDoAno,
        lastDate: anoQueVem);

    if (dataSelecionada != null) {
      data.value = dataSelecionada;
      var formatter = DateFormat('dd/MM/yyyy');
      dataController.text = formatter.format(dataSelecionada);
    }
  }
}
