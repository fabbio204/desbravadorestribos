import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/widgets/lancamento_widget.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter/material.dart';

import 'package:desbravadores_tribos/app/modules/financeiro/models/financeiro_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class FinanceiroTabs extends StatefulWidget {
  final FinanceiroModel model;
  const FinanceiroTabs({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<FinanceiroTabs> createState() => _FinanceiroTabsState();
}

class _FinanceiroTabsState extends State<FinanceiroTabs>
    with SingleTickerProviderStateMixin {
  FinanceiroController controller = Modular.get();

  late TabController tabController;
  ValueNotifier<int> tabAtual = ValueNotifier(0);

  @override
  void initState() {
    tabController =
        TabController(length: widget.model.saldoCaixas.length, vsync: this);
    tabController.addListener(() {
      tabAtual.value = tabController.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.model.saldoCaixas.length,
      child: Column(
        children: [
          Material(
            color: context.primaryColor,
            child: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: widget.model.saldoCaixas.asMap().entries.map(
                (e) {
                  int index = e.key;
                  CaixaModel caixaModel = e.value;
                  return Tab(
                    child: Column(
                      key: UniqueKey(),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(caixaModel.nome),
                        ValueListenableBuilder<int>(
                          valueListenable: tabAtual,
                          builder: (context, int tabSelecionada, child) {
                            if (tabSelecionada != index) {
                              return Container();
                            }

                            return gerarSaldo(caixaModel.saldo);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: widget.model.saldoCaixas.map(
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
                        return LancamentoWidget(model: e.lancamentos![index]);
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          )
        ],
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
