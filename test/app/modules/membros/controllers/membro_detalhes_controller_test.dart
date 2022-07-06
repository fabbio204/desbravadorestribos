import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/controllers/membro_detalhes_controller.dart';
import 'package:mocktail/mocktail.dart';

class MembroRepositoryMock extends Mock implements MembroRepository {}

void main() {
  group('Testa MembroDetalhesController', () {
    test('Testa MembroDetalhesController retornando dados corretamente',
        () async {
      MembroRepositoryMock repositoryMock = MembroRepositoryMock();
      MembroDetalhesController controller =
          MembroDetalhesController(repositoryMock);

      when(() => repositoryMock.listarLancamentos(any())).thenAnswer(
        (_) async => [
          LancamentoModel(
            data: '01/01/2021',
            descricao: 'Lancamento 1',
            subCaixa: '',
          )
        ],
      );

      Future<void> future = controller.listarLancamentos('Teste 1');

      expect(controller.isLoading, true);

      future.then((value) {
        expect(controller.isLoading, false);
        expect(controller.state, isNotNull);
        expect(controller.state.length, equals(1));
      });
    });

    test('Testa MembroController recebendo erro', () async {
      var repositoryMock = MembroRepositoryMock();

      when(() => repositoryMock.listarLancamentos(any()))
          .thenThrow(Exception('Erro ao carregar os lançamentos'));

      var controller = MembroDetalhesController(repositoryMock);

      Future<void> future = controller.listarLancamentos('Teste 2');

      future.then((value) {
        expect(controller.error, isNotNull);
      });
    });
  });
}
