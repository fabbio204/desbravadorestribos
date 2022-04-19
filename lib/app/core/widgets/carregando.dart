import 'package:flutter/material.dart';

class Carregando extends StatelessWidget {
  const Carregando({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}