import 'package:desbravadores_tribos/app/modules/calendario/controllers/eventos_controller.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_base.dart';
import '../membros/repositories/membro_repository_test.dart';

void main() {
  group('Testa MembroController', () {
    late GoogleApiMock api;
    late CalendarioRepository repository;
    late EventoController controller;

    setUpAll(() {
      api = GoogleApiMock();
      repository = CalendarioRepository(api);
      controller = EventoController(repository);

      registerFallbackValue(Event());
    });
    test('Testa CalendarioController resultando sucesso', () async {
      List<Event> eventos = [
        Event(
            id: 'id1',
            summary: "Teste 1",
            start: EventDateTime(date: DateTime.now())),
        Event(
            id: 'id2',
            summary: "Teste 2",
            start: EventDateTime(date: DateTime.now())),
        Event(
            id: 'id3',
            summary: "Teste 3",
            start: EventDateTime(date: DateTime.now())),
      ];

      List<List<StringMock>> membros = [
        [
          StringMock('Nome Teste'),
          StringMock('01/01/1990'),
          StringMock('Juda'),
          StringMock('01/01/2022')
        ],
      ];

      when(() => api.listarEventos(
            timeMin: any<DateTime>(named: "timeMin"),
            timeMax: any<DateTime>(named: "timeMax"),
            maxResults: any<int>(named: "maxResults"),
            orderBy: any<String>(named: "orderBy"),
          )).thenAnswer((_) => Future.value(Events(items: eventos)));

      when(() => api.getPlanilha(any())).thenAnswer(
        (_) => Future.value(ValueRange(values: membros)),
      );

      Future<void> future = controller.init();

      expect(controller.isLoading, true);

      future.then((value) {
        expect(controller.isLoading, false);
        expect(controller.state, isNotNull);
        expect(
            controller.state.length, equals(eventos.length + membros.length));
      });
    });

    test('Testa MembroController recebendo erro', () async {
      when(() => api.listarEventos(
            timeMin: any<DateTime>(named: "timeMin"),
            timeMax: any<DateTime>(named: "timeMax"),
            maxResults: any<int>(named: "maxResults"),
            orderBy: any<String>(named: "orderBy"),
          )).thenThrow(Exception('Erro ao carregar os eventos'));

      when(() => api.getPlanilha(any()))
          .thenThrow(Exception('Erro ao carregar os aniversariantes'));

      Future<void> future = controller.init();

      future.then((value) {
        expect(controller.error, isNotNull);
      });
    });
  });
}
