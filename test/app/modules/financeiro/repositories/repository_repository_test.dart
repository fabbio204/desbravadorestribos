import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_base.dart';

void main() {
  late GoogleApiMock api;
  late FinanceiroRepository repository;

  setUpAll(() {
    api = GoogleApiMock();
    repository = FinanceiroRepository(api);
  });

  test('Testa FinanceiroRepository.saldoCaixas com 1 resultado', () async {
    List<List<Object>> valores = [
      [
        Object.fromJson({0: 'Geral'}),
        Object.fromJson({0: '0,00'}),
      ]
    ];

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: valores));

    List<CaixaModel> resultado = await repository.saldoCaixas();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, valores.length);
  });

  test('Testa FinanceiroRepository.saldoCaixas com 0 resultado', () async {
    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: null));

    List<CaixaModel> resultado = await repository.saldoCaixas();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });

  test('Testa FinanceiroRepository.subCaixas com 2 resultados', () async {
    List<List<Object>> valores = [
      [
        Object.fromJson({0: 'Geral'}),
      ],
      [
        Object.fromJson({0: 'Campori'}),
      ],
    ];

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: valores));

    List<String> resultado = await repository.subCaixas();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, valores.length);
  });

  test('Testa FinanceiroRepository.subCaixas com 0 resultado', () async {
    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: null));

    List<String> resultado = await repository.subCaixas();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });

  test('Testa FinanceiroRepository.lancamentos com 2 resultados', () async {
    List<List<Object>> valores = [
      [
        Object.fromJson({0: '01/01/2022'}),
        Object.fromJson({0: 'Teste 1'}),
        Object.fromJson({0: '50,00'}),
        Object.fromJson({0: ''}),
        Object.fromJson({0: 'Geral'}),
        Object.fromJson({0: ''}),
      ],
      [
        Object.fromJson({0: '01/01/2022'}),
        Object.fromJson({0: 'Teste 2'}),
        Object.fromJson({0: ''}),
        Object.fromJson({0: '50,00'}),
        Object.fromJson({0: 'Geral'}),
        Object.fromJson({0: ''}),
      ],
    ];

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: valores));

    List<LancamentoModel> resultado = await repository.lancamentos();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, valores.length);
  });

  test('Testa FinanceiroRepository.lancamentos com 0 resultado', () async {
    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: null));

    List<LancamentoModel> resultado = await repository.lancamentos();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });
}
