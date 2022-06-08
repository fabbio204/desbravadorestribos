import 'package:desbravadores_tribos/app/modules/calendario/controllers/eventos_controller.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CalendarioRepositoryMock extends Mock implements CalendarioRepository {}

void main() {
  group('Testa MembroController', () {
    test('Testa CalendarioController resultando sucesso', () async {
      var repositoryMock = CalendarioRepositoryMock();

      when(repositoryMock.calendarioCompleto).thenAnswer((_) async => [
            EventoModel(
              dia: DateTime(2022, 1, 1),
              titulo: 'Primeiro evento 2022',
            ),
          ]);

      var controller = EventoController(repositoryMock);

      Future<void> future = controller.init();

      expect(controller.isLoading, true);

      future.then((value) {
        expect(controller.isLoading, false);
        expect(controller.state, isNotNull);
        expect(controller.state.length, equals(1));
      });
    });

    test('Testa MembroController recebendo erro', () async {
      var repositoryMock = CalendarioRepositoryMock();

      when(repositoryMock.calendarioCompleto)
          .thenThrow(Exception('Erro ao carregar os eventos'));

      var controller = EventoController(repositoryMock);

      Future<void> future = controller.init();

      future.then((value) {
        expect(controller.error, isNotNull);
      });
    });
  });
}
