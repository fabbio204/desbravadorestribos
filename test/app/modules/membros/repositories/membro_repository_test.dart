import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_base.dart';

class StringMock extends Object {
  final String value;

  StringMock(this.value);

  @override
  String toString() {
    return value;
  }
}

void main() {
  late GoogleApiMock api;
  late MembroRepository repository;

  setUpAll(() {
    api = GoogleApiMock();
    repository = MembroRepository(api);
  });

  test('Testa MembroRepository.listar com 2 membros', () async {
    List<List<Object>> valores = [
      [
        StringMock('url'),
        StringMock('Nome'),
        StringMock('01/01/2022'),
        StringMock('01/01/2022'),
        StringMock(''),
        StringMock('10'),
      ],
      [
        StringMock('url'),
        StringMock('Nome'),
        StringMock('01/01/2022'),
        StringMock('01/01/2022'),
        StringMock(''),
        StringMock('10'),
      ],
    ];

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: valores));

    List<MembroModel> resultado = await repository.listar();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, valores.length);
  });

  test('Testa MembroRepository.listar com 0 membros', () async {
    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: null));

    List<MembroModel> resultado = await repository.listar();

    expect(resultado, isNotNull);
    expect(resultado, isEmpty);
    expect(resultado.length, 0);
  });
}
