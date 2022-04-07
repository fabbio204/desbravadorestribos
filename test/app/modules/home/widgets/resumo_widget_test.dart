import 'package:desbravadores_tribos/app/modules/home/widgets/resumo_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

main() {
  group('ResumoWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget((ResumoWidget(
        titulo: 'T',
        valor: '',
      )));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}
