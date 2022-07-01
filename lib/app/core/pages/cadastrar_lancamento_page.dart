import 'package:brasil_fields/brasil_fields.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/controllers/cadastrar_lancamento_store.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class CadastrarLancamentoPage extends StatefulWidget {
  const CadastrarLancamentoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarLancamentoPage> createState() =>
      _CadastrarLancamentoPageState();
}

class _CadastrarLancamentoPageState
    extends ModularState<CadastrarLancamentoPage, CadastrarLancamentoStore> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController dataController = TextEditingController();

  late FinanceiroRepository financeiroRepository;
  late MembroRepository membroRepository;

  ValueNotifier<String> descricao = ValueNotifier('');
  ValueNotifier<String> subCaixa = ValueNotifier('');
  ValueNotifier<String> envolvido = ValueNotifier('');
  ValueNotifier<String> entrada = ValueNotifier('');
  ValueNotifier<String> saida = ValueNotifier('');
  ValueNotifier<DateTime> data = ValueNotifier(DateTime.now());

  @override
  void initState() {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    dataController.text = formatter.format(data.value);

    financeiroRepository = Modular.get();
    membroRepository = Modular.get();

    super.initState();
  }

  @override
  void dispose() {
    Modular.dispose<FinanceiroRepository>();
    Modular.dispose<MembroRepository>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text('Cadastrar Lançamento')),
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
                        return DropdownButtonFormField<String>(
                          itemHeight: null,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Envolvido',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }

                            return null;
                          },
                          items: snapshot.data!
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          return null;
                        },
                        items: const [],
                        onChanged: (String? value) {
                          envolvido.value = value ?? '';
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool? valido = _formKey.currentState?.validate();
                    if (valido != null && valido) {
                      LancamentoModel model = LancamentoModel(
                        data: dataController.text,
                        descricao: descricao.value,
                        subCaixa: subCaixa.value,
                        envolvido: envolvido.value,
                        entrada: entrada.value,
                        saida: saida.value,
                      );

                      await store.cadastrar(model);
                      if (store.state) {
                        bool recarregarTela = true;
                        Navigator.pop(context, recarregarTela);
                      }
                    }
                  },
                  child: const Text('Salvar'),
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
