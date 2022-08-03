import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSheetsApi implements GoogleApiBase {
  String get _idPlanilha => const String.fromEnvironment('ID_PLANILHA');
  String get _idCalendario => const String.fromEnvironment('ID_CALENDARIO');

  @override
  Future<Events> listarEventos({
    String? orderBy,
    DateTime? timeMin,
    DateTime? timeMax,
    int maxResults = 250,
  }) async {
    var calendario = await conectarCalendario();

    return calendario.events.list(_idCalendario,
        orderBy: orderBy,
        singleEvents: true,
        timeMin: timeMin,
        timeMax: timeMax,
        maxResults: maxResults);
  }

  @override
  Future<ValueRange> getPlanilha(String intervalo) async {
    var planilha = await conectarPlanilha();
    return planilha.spreadsheets.values.get(_idPlanilha, intervalo);
  }

  @override
  Future<void> setPlanilha(String intervalo, String valor) async {
    var planilha = await conectarPlanilha();

    await planilha.spreadsheets.values.update(
        ValueRange(range: intervalo, values: [
          [valor]
        ]),
        _idPlanilha,
        intervalo,
        valueInputOption: 'USER_ENTERED');
  }

  @override
  Future<void> setPlanilhaConjunto(
      String intervalo, List<List<Object>> valor) async {
    SheetsApi planilha = await conectarPlanilha();

    await planilha.spreadsheets.values.update(
        ValueRange(range: intervalo, values: valor), _idPlanilha, intervalo,
        valueInputOption: 'USER_ENTERED');
  }

  @override
  Future<void> cadastrarEvento(Event evento) async {
    CalendarApi calendario = await conectarCalendario();

    await calendario.events.insert(
      evento,
      _idCalendario,
      sendNotifications: true,
    );
  }

  @override
  Future<void> excluirEvento(String id) async {
    CalendarApi calendario = await conectarCalendario();

    await calendario.events.delete(
      _idCalendario,
      id,
      sendUpdates: 'all',
    );
  }

  @override
  Future<void> editarEvento(Event evento) async {
    CalendarApi calendario = await conectarCalendario();

    await calendario.events.update(evento, _idCalendario, evento.id!);
  }

  @override
  Future<void> excluirLinha(int row) async {
    SheetsApi planilha = await conectarPlanilha();

    List<List<String>> valores = [
      ['', '', '', '', '', '']
    ];

    String intervalo = 'Caixa!A$row:F$row';

    // coloca vazio nas colunas
    await planilha.spreadsheets.values.update(
        ValueRange(range: intervalo, values: valores), _idPlanilha, intervalo,
        valueInputOption: 'USER_ENTERED');

    Spreadsheet consulta =
        await planilha.spreadsheets.get(_idPlanilha, ranges: [intervalo]);

    int? sheetId = consulta.sheets![0].properties!.sheetId;

    // ordena o filtro
    await planilha.spreadsheets.batchUpdate(
      BatchUpdateSpreadsheetRequest(requests: [
        Request(
          sortRange: SortRangeRequest(
            range: GridRange(
              sheetId: sheetId,
              startColumnIndex: 0,
              startRowIndex: 6,
              endColumnIndex: 5,
            ),
            sortSpecs: [SortSpec(sortOrder: "ASCENDING")],
          ),
        )
      ]),
      _idPlanilha,
    );
  }

  static Future<SheetsApi> conectarPlanilha() async {
    return SheetsApi(await client);
  }

  static Future<CalendarApi> conectarCalendario() async {
    return CalendarApi(await clientCalendario);
  }

  static const List<String> _scopesSheets = [
    SheetsApi.spreadsheetsScope,
    SheetsApi.driveScope,
  ];

  static const List<String> _scopesCalendar = [
    CalendarApi.calendarScope,
    CalendarApi.calendarEventsScope,
  ];

  static Future<http.Client> get client async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var chave = const String.fromEnvironment('API_KEY');
    String decoded = stringToBase64.decode(chave);
    var credenciais = await obtainAccessCredentialsViaServiceAccount(
        ServiceAccountCredentials.fromJson(decoded),
        _scopesSheets,
        http.Client());

    AuthClient client = authenticatedClient(http.Client(), credenciais);

    return client;
  }

  static Future<http.Client> get clientCalendario async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    var chave = const String.fromEnvironment('API_KEY');
    String decoded = stringToBase64.decode(chave);
    var credenciais = await obtainAccessCredentialsViaServiceAccount(
        ServiceAccountCredentials.fromJson(decoded),
        _scopesCalendar,
        http.Client());

    AuthClient client = authenticatedClient(http.Client(), credenciais);

    return client;
  }
}
