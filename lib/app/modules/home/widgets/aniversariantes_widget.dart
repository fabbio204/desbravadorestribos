import 'package:flutter/material.dart';
import 'package:desbravadores_tribos/app/core/models/aniversariante_model.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariante_card_widget.dart';

class AniversariantesWidget extends StatelessWidget {
  final List<AniversarianteModel> aniversariantes;
  const AniversariantesWidget({Key? key, required this.aniversariantes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: aniversariantes.length,
      itemBuilder: (context, index) =>
          AniversarianteCardWidget(aniversariante: aniversariantes[index]),
    );
  }
}
