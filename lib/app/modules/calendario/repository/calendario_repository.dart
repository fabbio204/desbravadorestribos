import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:googleapis/sheets/v4.dart';

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
}
