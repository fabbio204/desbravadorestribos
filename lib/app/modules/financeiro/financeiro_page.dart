import 'package:desbravadores_tribos/app/app_module.dart';
import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/financeiro_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/widgets/lancamento_widget.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';

class FinanceiroPage extends StatefulWidget {
  const FinanceiroPage({Key? key}) : super(key: key);
  @override
  FinanceiroPageState createState() => FinanceiroPageState();
}

class FinanceiroPageState
    extends ModularState<FinanceiroPage, FinanceiroController> {
  @override
  void initState() {
    super.initState();

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<FinanceiroController, Exception,
        FinanceiroModel>.transition(
      store: store,
      onLoading: (_) => const Carregando(),
      onError: (_, erro) => LogErro(erro: erro),
      onState: (context, financeiro) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            bool? atualizar = await Modular.to
                .pushNamed<bool>(AppModule.rotaCadastrarLancamento);

            if (atualizar != null && atualizar) {
              controller.init();
            }
          },
        ),
        body: DefaultTabController(
          length: financeiro.saldoCaixas.length,
          child: Column(
            children: [
              Material(
                color: context.primaryColor,
                child: TabBar(
                  isScrollable: true,
                  tabs: financeiro.saldoCaixas
                      .map(
                        (e) => Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(e.nome),
                              gerarSaldo(e.saldo),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: financeiro.saldoCaixas.map(
                    (e) {
                      if (e.lancamentos == null || e.lancamentos!.isEmpty) {
                        return const Center(
                          child: Text('Sem lançamentos'),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          controller.init();
                        },
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: e.lancamentos!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LancamentoWidget(
                                model: e.lancamentos![index]);
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  gerarSaldo(String? saldo) {
    if (saldo == null) {
      return Container();
    }

    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    String valor = saldo.replaceAll("R\$ ", "");

    var numero = numberFormat.parse(valor);

    if (numero < 0) {
      return Text(
        saldo,
        style: const TextStyle(color: Colors.redAccent),
      );
    }

    return Text(saldo);
  }
}
