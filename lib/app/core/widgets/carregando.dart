import 'package:flutter/material.dart';
import 'dart:math';

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
        duration: const Duration(milliseconds: 500), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: ShakeCurve(),
      child: Image.asset('triangulo.png'),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ShakeCurve extends Curve {
  // https://docs.flutter.dev/development/ui/animations/tutorial
  @override
  double transform(double t) => sin(t * pi * 2);
}
