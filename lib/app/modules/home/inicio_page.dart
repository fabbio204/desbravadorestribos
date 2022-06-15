import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/core/widgets/log_erro.dart';
import 'package:desbravadores_tribos/app/modules/calendario/widgets/proximos_eventos_widget.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/models/home_model.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariantes_widget.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/resumo_widget.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:url_launcher/url_launcher.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends ModularState<InicioPage, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<HomeController, Exception, HomeModel>.transition(
      store: controller,
      onLoading: (_) => const Carregando(),
      onError: (_, erro) => LogErro(erro: erro),
      onState: (context, value) => Column(
        children: [
          if (value.temNovaVersao)
            MaterialBanner(
              padding: const EdgeInsets.all(10),
              leading: const Icon(Icons.new_releases),
              content: const Text('Existe uma nova versão do aplicativo'),
              actions: [
                TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                      const String.fromEnvironment('URL_APK'),
                    ));
                  },
                  child: const Text('Baixar'),
                )
              ],
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: context.screenWidth,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: value.resumo
                          .map((e) => ResumoWidget(
                                titulo: e.titulo,
                                valor: e.valor,
                              ))
                          .toList(),
                    ),
                  ),
                  AniversariantesWidget(aniversariantes: value.aniversariantes),
                  ProximosEventosWidget(eventos: value.eventos),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
