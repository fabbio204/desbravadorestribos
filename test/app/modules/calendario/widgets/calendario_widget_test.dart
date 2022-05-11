import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/calendario/widgets/proximos_eventos_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('CalendarioWidget', () {
    testWidgets('has a title and message', (WidgetTester tester) async {
      List<EventoModel> listaEventos = [
        EventoModel(dia: DateTime.now(), titulo: 'Evento 1'),
        EventoModel(dia: DateTime.now(), titulo: 'Evento 2'),
        EventoModel(dia: DateTime.now(), titulo: 'Evento 3'),
      ];
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 1000,
                    width: 1000,
                    child: ProximosEventosWidget(eventos: listaEventos),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final Finder titleFinder = find.byKey(const Key('tituloEventos'));
      expect(titleFinder, findsOneWidget);

      final Finder eventos = find.byKey(const Key('listaEventos'));
      expect(eventos, findsOneWidget);
    });
  });
}
