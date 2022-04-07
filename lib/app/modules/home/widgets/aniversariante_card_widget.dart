import 'package:flutter/material.dart';
import 'package:desbravadores_tribos/app/core/models/aniversariante_model.dart';

class AniversarianteCardWidget extends StatelessWidget {
  final AniversarianteModel aniversariante;
  const AniversarianteCardWidget({Key? key, required this.aniversariante})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(aniversariante.nome),
        subtitle: Text(aniversariante.dia),
      ),
    );
  }
}
