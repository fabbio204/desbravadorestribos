import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/calendario/controllers/cadastrar_evento_store.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_base.dart';

void main() {
  late CalendarioRepository repository;
  late GoogleApiMock api;
  late CadastrarEventoController controller;

  setUpAll(() {
    api = GoogleApiMock();
    repository = CalendarioRepository(api);
    controller = CadastrarEventoController(repository);

    registerFallbackValue(Event());
  });

  test('Testa CadastrarEventoController resultando sucesso', () {
    when(() => api.cadastrarEvento(any())).thenAnswer((_) => voidFunction());

    Future<void> future = controller.salvar('Teste Evento 1', DateTime.now());

    expect(controller.isLoading, true);

    future.then((value) {
      expect(controller.isLoading, false);
      expect(controller.state, isNotNull);
      expect(controller.state, true);
    });
  });

  test('Testa CadastrarEventoController resultando erro', () async {
    when(() => api.cadastrarEvento(any()))
        .thenThrow(Exception('Erro ao salvar o evento'));

    await controller.salvar('Teste Evento 2', DateTime.now());

    expect(controller.error, isNotNull);
  });
}
