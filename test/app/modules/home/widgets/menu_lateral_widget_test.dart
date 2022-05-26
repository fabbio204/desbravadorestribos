import 'package:desbravadores_tribos/app/modules/home/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('MenuLateralWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery(
                data: MediaQueryData(),
                child: SingleChildScrollView(
                    child: SizedBox(
                        height: 100, width: 100, child: MenuLateralWidget()))),
          ),
        ),
      );
      final titleFinder = find.byKey(const Key('listaItensMenu'));
      expect(titleFinder, findsOneWidget);
    });
  });
}
