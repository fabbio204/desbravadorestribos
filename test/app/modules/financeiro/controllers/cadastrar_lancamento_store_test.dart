import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/controllers/cadastrar_lancamento_store.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_base.dart';
import '../../membros/repositories/membro_repository_test.dart';

void main() {
  late FinanceiroRepository repository;
  late GoogleApiMock api;
  late CadastrarLancamentoStore controller;

  setUpAll(() {
    api = GoogleApiMock();
    repository = FinanceiroRepository(api);
    controller = CadastrarLancamentoStore(repository);

    // registerFallbackValue(Event());
  });

  test('Testa CadastrarEventoController resultando sucesso', () {
    when(() => api.setPlanilhaConjunto(any(), any()))
        .thenAnswer((_) => voidFunction());

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: [
              [StringMock('1')]
            ]));

    Future<void> future = controller.cadastrar(LancamentoModel(
      data: '01/01/2022',
      descricao: 'Teste',
      subCaixa: 'SubCaixa',
      envolvido: '',
      entrada: '',
      saida: '',
    ));

    expect(controller.isLoading, true);

    future.then((value) {
      expect(controller.isLoading, false);
      expect(controller.state, isNotNull);
      expect(controller.state, true);
    });
  });

  test('Testa CadastrarEventoController resultando erro', () async {
    when(() => api.setPlanilhaConjunto(any(), any()))
        .thenThrow(Exception('Ocorreu um erro ao cadastrar'));

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: [
              [StringMock('1')]
            ]));

    await controller.cadastrar(LancamentoModel(
      data: '01/01/2022',
      descricao: 'Teste',
      subCaixa: 'SubCaixa',
      envolvido: '',
      entrada: '',
      saida: '',
    ));

    expect(controller.error, isNotNull);
  });
}
