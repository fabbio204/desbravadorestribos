import 'package:desbravadores_tribos/app/modules/calendario/widgets/calendario_widget.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/models/home_state.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariantes_widget.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/resumo_widget.dart';
import 'package:desbravadores_tribos/app/utils/extensions/build_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/menu_lateral_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    controller.carregar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      body: ValueListenableBuilder<HomeState>(
        valueListenable: controller,
        builder: ((BuildContext context, HomeState value, Widget? child) {
          if (value is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                  CalendarioWidget(eventos: value.model.eventos),
                ],
              ),
            );
          }

          return const SizedBox();
        }),
      ),
      drawer: const MenuLateralWidget(),
    );
  }
}
