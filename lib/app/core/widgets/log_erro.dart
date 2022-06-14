import 'package:flutter/material.dart';

class LogErro extends StatelessWidget {
  final Exception? erro;
  const LogErro({Key? key, required this.erro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Ocorreu um erro. ${erro.toString()}',
            key: const Key('mensagemErro')),
      ),
    );
  }
}
