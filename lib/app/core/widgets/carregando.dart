import 'package:flutter/material.dart';

class Carregando extends StatefulWidget {
  const Carregando({Key? key}) : super(key: key);

  @override
  State<Carregando> createState() => _CarregandoState();
}

class _CarregandoState extends State<Carregando> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    animation = Tween<double>(begin: 75, end: 85).animate(controller)
      ..addListener(() {
        setState(() {
          // Aciona a mudança de estado para atualizar o tamanho do ícone
        });
      })
      ..addStatusListener((status) {
        // controles para fazer loop infinito da animação
        if (status == AnimationStatus.completed) {
          // finaliza
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // inicia
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        key: const Key('iconeCarregando'),
        height: animation.value,
        width: animation.value,
        child: Image.asset('triangulo.png'),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
