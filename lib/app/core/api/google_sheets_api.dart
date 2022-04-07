import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'dart:convert';

class GoogleSheetsApi {
  static SheetsApi? api;

  static String get id => const String.fromEnvironment('ID_PLANILHA');

  static Future init() async {
    api = await conectar();
  }

  static conectar() async {
    return SheetsApi(await client);
  }

  static const List<String> _scopes = [
    SheetsApi.spreadsheetsScope,
    SheetsApi.driveScope,
  ];

  static Future<Client> get client async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var chave = const String.fromEnvironment('API_KEY');
    String decoded = stringToBase64.decode(chave);
    var credenciais = await obtainAccessCredentialsViaServiceAccount(
        ServiceAccountCredentials.fromJson(decoded), _scopes, Client());

    AuthClient client = authenticatedClient(Client(), credenciais);

    return client;
  }
}
