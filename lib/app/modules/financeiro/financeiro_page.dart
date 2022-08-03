import 'package:desbravadores_tribos/app/app_module.dart';
import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/financeiro_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/widgets/financeiro_tabs.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

class FinanceiroPage extends StatefulWidget {
  const FinanceiroPage({Key? key}) : super(key: key);
  @override
  FinanceiroPageState createState() => FinanceiroPageState();
}

class FinanceiroPageState extends State<FinanceiroPage> {
  FinanceiroController controller = Modular.get();
  
  @override
  void initState() {
    super.initState();

    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<FinanceiroController, Exception,
        FinanceiroModel>.transition(
      store: controller,
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
        body: FinanceiroTabs(model: financeiro),
      ),
    );
  }
}
