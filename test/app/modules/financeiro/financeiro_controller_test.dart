import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FinanceiroRepositoryMock extends Mock implements FinanceiroRepository {}

void main() {
  group('Testa FinanceiroController', () {
    test('Testa MembroController resultando sucesso', () async {
      var repositoryMock = FinanceiroRepositoryMock();

      when(repositoryMock.saldoCaixas).thenAnswer((_) async => [
            CaixaModel(nome: 'Geral', saldo: '0,00'),
            CaixaModel(nome: 'Unidades 1', saldo: '0,00'),
          ]);

      when(repositoryMock.lancamentos).thenAnswer((_) async => [
            LancamentoModel(
              data: '01/01/2022',
              descricao: 'Saldo 2021',
              subCaixa: 'Geral',
              entrada: '200',
              envolvido: 'Clube',
            ),
            LancamentoModel(
              data: '01/01/2022',
              descricao: 'Lanches da primeira reunião',
              subCaixa: 'Geral',
              saida: '100',
              envolvido: 'Clube',
            ),
          ]);

      var controller = FinanceiroController(repositoryMock);

      Future<void> future = controller.init();

      expect(controller.isLoading, true);

      future.then((value) {
        expect(controller.isLoading, false);
        expect(controller.state, isNotNull);
        expect(controller.state.lancamentos.length, equals(2));
      });
    });

    test('Testa FinanceiroController recebendo erro', () async {
      var repositoryMock = FinanceiroRepositoryMock();

      when(repositoryMock.saldoCaixas)
          .thenThrow(Exception('Erro ao carregar os os caixas'));

      var controller = FinanceiroController(repositoryMock);

      Future<void> future = controller.init();

      future.then((value) {
        expect(controller.error, isNotNull);
      });
    });
  });
}
