import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/financeiro_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/widgets/lancamento_widget.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

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
    return ScopedBuilder<FinanceiroController, Exception, FinanceiroModel>(
      store: store,
      onLoading: (_) => const Carregando(),
      onError: (_, erro) => LogErro(erro: erro),
      onState: (context, financeiro) => DefaultTabController(
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
                            if (e.saldo != null) Text(e.saldo!),
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

                    return ListView.builder(
                      itemCount: e.lancamentos!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LancamentoWidget(model: e.lancamentos![index]);
                      },
                    );
                  },
                ).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
