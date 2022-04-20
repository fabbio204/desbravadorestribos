import 'package:desbravadores_tribos/app/modules/calendario/widgets/proximos_eventos_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

main() {
  group('CalendarioWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget((ProximosEventosWidget(eventos: [],)));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}