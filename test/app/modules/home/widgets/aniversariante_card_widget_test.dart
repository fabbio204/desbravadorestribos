import 'package:desbravadores_tribos/app/core/models/aniversariante_model.dart';
import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariante_card_widget.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('AniversarianteCardWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget((AniversarianteCardWidget(
        aniversariante: AniversarianteModel(dia: '01/01', nome: 'Usuario'),
      )));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}
