import 'package:desbravadores_tribos/app/modules/home/widgets/resumo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('ResumoWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(const MediaQuery(
        data: MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: ResumoWidget(
            titulo: 'T',
            valor: '',
          ),
        ),
      ));
      final titulo = find.byKey(const Key('titulo'));
      expect(titulo, findsOneWidget);

      final valor = find.byKey(const Key('valor'));
      expect(valor, findsOneWidget);
    });
  });
}
