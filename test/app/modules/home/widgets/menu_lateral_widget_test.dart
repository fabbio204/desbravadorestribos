import 'package:desbravadores_tribos/app/modules/home/widgets/menu_lateral_widget.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('MenuLateralWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget((MenuLateralWidget()));
      final titleFinder = find.text('T');
      expect(titleFinder, findsOneWidget);
    });
  });
}
