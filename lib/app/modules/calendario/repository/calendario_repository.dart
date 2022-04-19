import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:intl/intl.dart';

class CalendarioRepository {
  Future<List<EventoModel>> proximosEventos() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!D12:E21');

    if (resultados.values == null) {
      return [];
    }

    List<EventoModel> aniversariantes =
        resultados.values!.map((List<Object?> item) {
      List<String> numerosData = item[0].toString().split('/');
      String novaData = numerosData.reversed.join('-');

      return EventoModel(
          dia: DateTime.parse(novaData), titulo: item[1].toString());
    }).toList();

    return aniversariantes;
  }

  Future<List<EventoModel>> calendarioCompleto() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Calendario!A3:C');

    if (resultados.values == null) {
      return [];
    }

    DateFormat format = DateFormat('dd/MM/yyyy');

    List<EventoModel> eventos = resultados.values!.map((List<Object?> item) {
      DateTime novaData = format.parse(item[0].toString());

      return EventoModel(dia: novaData, titulo: item[1].toString());
    }).toList();

    return eventos;
  }
}
