import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_base.dart';

void main() {
  late CalendarioRepository repository;
  late GoogleApiMock api;

  setUpAll(() {
    api = GoogleApiMock();
    repository = CalendarioRepository(api);
  });

  test('Testa CalendarioRepository - calendarioCompleto() com 3 eventos', () async {
    List<Event> eventos = [
      Event(summary: "Teste 1", start: EventDateTime(date: DateTime.now())),
      Event(summary: "Teste 2", start: EventDateTime(date: DateTime.now())),
      Event(summary: "Teste 3", start: EventDateTime(date: DateTime.now())),
    ];

    when(() => api.getEventos(
          timeMin: any<DateTime>(named: "timeMin"),
          timeMax: any<DateTime>(named: "timeMax"),
          maxResults: any<int>(named: "maxResults"),
          orderBy: any<String>(named: "orderBy"),
        )).thenAnswer((_) async => Events(items: eventos));

    var resultado = await repository.calendarioCompleto();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, eventos.length);
  });
  test('Testa CalendarioRepository - calendarioCompleto() com 0 eventos', () async {
    List<Event> eventos = [];

    when(() => api.getEventos(
          timeMin: any<DateTime>(named: "timeMin"),
          timeMax: any<DateTime>(named: "timeMax"),
          maxResults: any<int>(named: "maxResults"),
          orderBy: any<String>(named: "orderBy"),
        )).thenAnswer((_) async => Events(items: eventos));

    var resultado = await repository.calendarioCompleto();

    expect(resultado, isNotNull);
    expect(resultado.length, eventos.length);
  });
  test('Testa CalendarioRepository - calendarioCompleto() com null no retorno', () async {
    when(() => api.getEventos(
          timeMin: any<DateTime>(named: "timeMin"),
          timeMax: any<DateTime>(named: "timeMax"),
          maxResults: any<int>(named: "maxResults"),
          orderBy: any<String>(named: "orderBy"),
        )).thenAnswer((_) async => Events());

    var resultado = await repository.calendarioCompleto();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });
}
