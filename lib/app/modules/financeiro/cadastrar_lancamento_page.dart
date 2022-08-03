import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';

import 'package:desbravadores_tribos/app/modules/financeiro/controllers/cadastrar_lancamento_store.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';

class CadastrarLancamentoArgumentos {
  int? id;
  String? nome;
  String? entrada;
  String? saida;
  String? descricao;
  String? caixa;
  String? data;
  bool? editar;
  CadastrarLancamentoArgumentos({
    this.id,
    this.nome,
    this.entrada,
    this.saida,
    this.descricao,
    this.caixa,
    this.data,
    this.editar,
  });
}

class CadastrarLancamentoPage extends StatefulWidget {
  final CadastrarLancamentoArgumentos? args;
  const CadastrarLancamentoPage({
    Key? key,
    this.args,
  }) : super(key: key);

  @override
  State<CadastrarLancamentoPage> createState() =>
      _CadastrarLancamentoPageState();
}

class _CadastrarLancamentoPageState extends State<CadastrarLancamentoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController dataController = TextEditingController();

  CadastrarLancamentoStore controller = Modular.get();
  FinanceiroRepository financeiroRepository = Modular.get();
  MembroRepository membroRepository = Modular.get();

  late ValueNotifier<String> envolvido;
  late ValueNotifier<String> descricao;
  late ValueNotifier<String> subCaixa;
  late ValueNotifier<String> entrada;
  late ValueNotifier<String> saida;
  late ValueNotifier<DateTime> data;

  late String titulo;
  late bool editar;

  @override
  void initState() {
    envolvido = ValueNotifier(widget.args?.nome ?? '');
    descricao = ValueNotifier(widget.args?.descricao ?? '');
    subCaixa = ValueNotifier(widget.args?.caixa ?? '');
    entrada = ValueNotifier(widget.args?.entrada ?? '');
    saida = ValueNotifier(widget.args?.saida ?? '');

    DateFormat formatter = DateFormat('dd/MM/yyyy');

    if (widget.args?.data != null) {
      var dateTime = formatter.parse(widget.args!.data!);
      data = ValueNotifier(dateTime);
    } else {
      data = ValueNotifier(DateTime.now());
    }

    dataController.text = formatter.format(data.value);

    editar = widget.args?.editar != null && widget.args?.editar == true;
    if (editar) {
      titulo = 'Editar Lançamento';
    } else {
      titulo = 'Cadastrar Lançamento';
    }

    controller.observer(
      onState: (state) {
        if (state) {
          bool recarregarTela = true;
          Navigator.pop(context, recarregarTela);
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<CadastrarLancamentoStore>();
    Modular.dispose<FinanceiroRepository>();
    Modular.dispose<MembroRepository>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 2,
                    maxLength: 70,
                    initialValue: descricao.value,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }

                      return null;
                    },
                    onChanged: (value) {
                      descricao.value = value;
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: entrada.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter()
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Entrada',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if ((value == null || value.isEmpty) &&
                                saida.value.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            entrada.value = value;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: saida.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter()
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Saída',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if ((value == null || value.isEmpty) &&
                                entrada.value.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            saida.value = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<String>>(
                    future: financeiroRepository.subCaixas(),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Caixa',
                            border: OutlineInputBorder(),
                          ),
                          value: widget.args?.caixa,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            return null;
                          },
                          items: snapshot.data!
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            subCaixa.value = value ?? '';
                          },
                        );
                      }

                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Caixa',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          return null;
                        },
                        items: const [],
                        onChanged: (String? value) {
                          subCaixa.value = value ?? '';
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<MembroModel>>(
                    future: membroRepository.listar(),
                    builder:
                        (context, AsyncSnapshot<List<MembroModel>> snapshot) {
                      if (snapshot.hasData) {
                        List<MembroModel> dados = snapshot.data!;
                        dados.insert(0, MembroModel(nome: ''));

                        return DropdownButtonFormField<String>(
                          itemHeight: null,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Envolvido',
                            border: OutlineInputBorder(),
                          ),
                          value: widget.args?.nome,
                          items: dados
                              .map(
                                (e) => DropdownMenuItem<String>(
                                  child: Text(
                                    e.nome,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  value: e.nome,
                                ),
                              )
                              .toList(),
                          onChanged: (String? value) {
                            envolvido.value = value ?? '';
                          },
                        );
                      }

                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Envolvido',
                          border: OutlineInputBorder(),
                        ),
                        items: const [],
                        onChanged: (String? value) {
                          envolvido.value = value ?? '';
                        },
                      );
                    },
                  ),
                ),
                ScopedBuilder<CadastrarLancamentoStore, Exception, bool>(
                  store: controller,
                  onError: (context, error) => Text(error.toString()),
                  onLoading: (context) => const CircularProgressIndicator(),
                  onState: (_, bool retorno) {
                    return ElevatedButton(
                      onPressed: () async {
                        bool? valido = _formKey.currentState?.validate();
                        if (valido != null && valido) {
                          LancamentoModel model = LancamentoModel(
                            id: widget.args?.id,
                            data: dataController.text,
                            descricao: descricao.value,
                            subCaixa: subCaixa.value,
                            envolvido: envolvido.value,
                            entrada: entrada.value,
                            saida: saida.value,
                          );
                          if (editar) {
                            controller.editar(model);
                          } else {
                            controller.cadastrar(model);
                          }
                        }
                      },
                      child: const Text('Salvar'),
                    );
                  },
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  void _abrirDatePicker() async {
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
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      dataController.text = formatter.format(dataSelecionada);
    }
  }
}
