import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/resumo_widget.dart';
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
    return ScopedBuilder<FinanceiroController, Exception, List<CaixaModel>>(
      store: store,
      onLoading: (_) => const Carregando(),
      onError: (_, erro) => LogErro(erro: erro),
      onState: (context, valores) => Column(children: [
        SizedBox(
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: valores.length,
              itemBuilder: (context, index) {
                CaixaModel caixa = valores[index];
                return ResumoWidget(titulo: caixa.nome, valor: caixa.saldo);
              }),
        )
      ]),
    );
  }
}
