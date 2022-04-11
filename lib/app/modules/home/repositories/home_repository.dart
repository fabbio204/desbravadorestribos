import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/core/models/aniversariante_model.dart';

class HomeRepository {
  Future<List<AniversarianteModel>> listarAniversariantes() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!A12:B21');

    if (resultados.values == null) {
      return [];
    }

    List<AniversarianteModel> aniversariantes =
        resultados.values!.map((List<Object?> item) {
      return AniversarianteModel(
          dia: item[0].toString(), nome: item[1].toString());
    }).toList();

    return aniversariantes;
  }

  Future<List<ResumoModel>> listarResumo() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!C2:D8');

    if (resultados.values == null) {
      return [];
    }

    List<ResumoModel> resumo = resultados.values!.map((List<Object?> item) {
      return ResumoModel(titulo: item[0].toString(), valor: item[1].toString());
    }).toList();

    return resumo;
  }

  Future<List<EventoModel>> proximosEventos() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!E12:F21');

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
