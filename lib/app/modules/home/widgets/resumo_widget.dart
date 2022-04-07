import 'package:flutter/material.dart';

class ResumoWidget extends StatelessWidget {
  final String titulo;
  final String valor;
  const ResumoWidget({Key? key, required this.titulo, required this.valor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        child: ListTile(
          isThreeLine: true,
          title: Text(titulo),
          subtitle: Text(valor),
        ),
      ),
    );
  }
}
