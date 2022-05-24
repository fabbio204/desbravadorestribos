import 'package:desbravadores_tribos/app/core/widgets/carregando.dart';
import 'package:desbravadores_tribos/app/modules/calendario/widgets/proximos_eventos_widget.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/models/home_state.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariantes_widget.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/resumo_widget.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    controller.carregar();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeState>(
      valueListenable: controller,
      builder: ((BuildContext context, HomeState value, Widget? child) {
        if (value is HomeLoadingState) {
          return const Carregando();
        }

        if (value is HomeErrorState) {
          return Center(
            child: Text(value.mensagem),
          );
        }

        if (value is HomeInitialState) {
          return const SizedBox();
        }

        if (value is HomeLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (value.model.temNovaVersao)
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
                SizedBox(
                  height: 80,
                  width: context.screenWidth,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: value.model.resumo
                        .map((e) => ResumoWidget(
                              titulo: e.titulo,
                              valor: e.valor,
                            ))
                        .toList(),
                  ),
                ),
                AniversariantesWidget(
                    aniversariantes: value.model.aniversariantes),
                ProximosEventosWidget(eventos: value.model.eventos),
              ],
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}
