import 'dart:convert';
import 'dart:typed_data';

import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis/storage/v1.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../test_base.dart';
import '../../../core/api/app_version_test.dart';

void main() {
  late GoogleApiMock api;
  Dio dio = Dio();
  late DioAdapterMock dioAdapterMock;
  late HomeRepository repository;

  setUpAll(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;
    api = GoogleApiMock();
    repository = HomeRepository(api, dio);

    registerFallbackValue(RequiredOptionsMock());
  });

  test('Testa HomeRepository.listarAniversariantes com 2 resultados', () async {
    List<List<Object>> valores = [
      [
        Object.fromJson({0: 'url'}),
        Object.fromJson({0: 'Nome'}),
        Object.fromJson({0: '01/01/2022'}),
      ],
      [
        Object.fromJson({0: 'url'}),
        Object.fromJson({0: 'Nome'}),
        Object.fromJson({0: '01/01/2022'}),
      ],
    ];

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: valores));

    List<MembroModel> resultado = await repository.listarAniversariantes();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, valores.length);
  });

  test('Testa HomeRepository.listarAniversariantes com 0 resultado', () async {
    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: null));

    List<MembroModel> resultado = await repository.listarAniversariantes();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });

  test('Testa HomeRepository.listarResumo com 2 resultados', () async {
    List<List<Object>> valores = [
      [
        Object.fromJson({0: 'url'}),
        Object.fromJson({0: 'Nome'}),
      ],
      [
        Object.fromJson({0: 'url'}),
        Object.fromJson({0: 'Nome'}),
      ],
    ];

    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: valores));

    List<ResumoModel> resultado = await repository.listarResumo();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, valores.length);
  });

  test('Testa HomeRepository.listarResumo com 0 resultado', () async {
    when(() => api.getPlanilha(any()))
        .thenAnswer((_) async => ValueRange(values: null));

    List<ResumoModel> resultado = await repository.listarResumo();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });

  test('Testa HomeRepository.proximosEventos com 3 eventos', () async {
    List<Event> eventos = [
      Event(summary: "Teste 1", start: EventDateTime(date: DateTime.now())),
      Event(summary: "Teste 2", start: EventDateTime(date: DateTime.now())),
      Event(summary: "Teste 3", start: EventDateTime(date: DateTime.now())),
    ];

    when(() => api.listarEventos(
          timeMin: any<DateTime>(named: "timeMin"),
          timeMax: any<DateTime>(named: "timeMax"),
          maxResults: any<int>(named: "maxResults"),
          orderBy: any<String>(named: "orderBy"),
        )).thenAnswer((_) async => Events(items: eventos));

    var resultado = await repository.proximosEventos();

    expect(resultado, isNotNull);
    expect(resultado, isNotEmpty);
    expect(resultado.length, eventos.length);
  });
  test('Testa HomeRepository.proximosEventos com 0 eventos', () async {
    List<Event> eventos = [];

    when(() => api.listarEventos(
          timeMin: any<DateTime>(named: "timeMin"),
          timeMax: any<DateTime>(named: "timeMax"),
          maxResults: any<int>(named: "maxResults"),
          orderBy: any<String>(named: "orderBy"),
        )).thenAnswer((_) async => Events(items: eventos));

    var resultado = await repository.proximosEventos();

    expect(resultado, isNotNull);
    expect(resultado.length, eventos.length);
  });
  test('Testa HomeRepository.proximosEventos com null no retorno', () async {
    when(() => api.listarEventos(
          timeMin: any<DateTime>(named: "timeMin"),
          timeMax: any<DateTime>(named: "timeMax"),
          maxResults: any<int>(named: "maxResults"),
          orderBy: any<String>(named: "orderBy"),
        )).thenAnswer((_) async => Events());

    var resultado = await repository.proximosEventos();

    expect(resultado, isNotNull);
    expect(resultado.length, 0);
  });

  test('Testa HomeRepository.temNovaVersao com nova versão', () async {
    final responsePayload = json.encode([
      {'name': '1.0.0'}
    ]);

    final ResponseBody httpResponse =
        ResponseBody.fromString(responsePayload, 200);

    when(() => dioAdapterMock.fetch(
            any<RequestOptions>(), any<Stream<Uint8List>?>(), any<Future?>()))
        .thenAnswer((_) async => httpResponse);

    PackageInfo.setMockInitialValues(
        appName: "abc",
        packageName: "com.example.example",
        version: "1.1.0",
        buildNumber: "1",
        buildSignature: "buildSignature");

    bool resultado = await repository.temNovaVersao();

    expect(resultado, true);
  });

  test('Testa HomeRepository.temNovaVersao com nova versão igual', () async {
    String versao = '1.0.0';
    final responsePayload = json.encode([
      {'name': versao}
    ]);

    final ResponseBody httpResponse =
        ResponseBody.fromString(responsePayload, 200);

    when(() => dioAdapterMock.fetch(
            any<RequestOptions>(), any<Stream<Uint8List>?>(), any<Future?>()))
        .thenAnswer((_) async => httpResponse);

    PackageInfo.setMockInitialValues(
        appName: "abc",
        packageName: "com.example.example",
        version: versao,
        buildNumber: "1",
        buildSignature: "buildSignature");

    bool resultado = await repository.temNovaVersao();

    expect(resultado, false);
  });
}
