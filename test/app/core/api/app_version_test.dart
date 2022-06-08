import 'dart:convert';
import 'dart:typed_data';

import 'package:desbravadores_tribos/app/core/api/app_version.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class RequiredOptionsMock extends Mock implements RequestOptions {}

void main() {
  Dio dio = Dio();
  late DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
    dio.httpClientAdapter = dioAdapterMock;

    registerFallbackValue(RequiredOptionsMock());
  });

  test('Testa buscar a versão do app no Github', () async {
    final responsePayload = json.encode([
      {'name': '1.0.0'}
    ]);

    final ResponseBody httpResponse =
        ResponseBody.fromString(responsePayload, 200);

    when(() => dioAdapterMock.fetch(
            any<RequestOptions>(), any<Stream<Uint8List>?>(), any<Future?>()))
        .thenAnswer((_) async => httpResponse);

    AppVersion appVersion = AppVersion(dio);
    var versao = await appVersion.releaseVersion();

    expect(versao, isNotEmpty);
  });
}
