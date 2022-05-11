import 'package:desbravadores_tribos/app/modules/home/widgets/aniversariantes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('AniversariantesWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  AniversariantesWidget(
                    aniversariantes: [],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      final titleFinder = find.byKey(const Key('listaAniversariantes'));
      expect(titleFinder, findsOneWidget);
    });
  });
}
