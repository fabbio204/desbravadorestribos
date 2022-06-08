import 'package:desbravadores_tribos/app/modules/membros/membro_controller.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MembroRepositoryMock extends Mock implements MembroRepository {}

void main() {
  group('Testa MembroController', () {
    test('Testa MembroController resultando sucesso', () async {
      var repositoryMock = MembroRepositoryMock();

      when(repositoryMock.listar)
          .thenAnswer((_) async => [MembroModel(nome: 'Usuario 1')]);

      var controller = MembroController(repositoryMock);

      Future<void> future = controller.init();

      expect(controller.isLoading, true);

      future.then((value) {
        expect(controller.isLoading, false);
        expect(controller.state, isNotNull);
        expect(controller.state.length, equals(1));
      });
    });

    test('Testa MembroController recebendo erro', () async {
      var repositoryMock = MembroRepositoryMock();

      when(repositoryMock.listar)
          .thenThrow(Exception('Erro ao carregar os usuários'));

      var controller = MembroController(repositoryMock);

      Future<void> future = controller.init();

      future.then((value) {
        expect(controller.error, isNotNull);
      });
    });
  });
}
