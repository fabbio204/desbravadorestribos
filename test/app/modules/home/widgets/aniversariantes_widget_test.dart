import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariantes_widget.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('AniversariantesWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget((AniversariantesWidget(
        aniversariantes: [],
      )));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}
