import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
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

  Future<String> quantidadeMembros() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!C4');

    if (resultados.values == null) {
      return "";
    }

    return resultados.values![0][0].toString();
  }

  Future<String> inscricoesCampori() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!E4');

    if (resultados.values == null) {
      return "";
    }

    return resultados.values![0][0].toString();
  }

  Future<String> saldoCaixa() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!C7');

    if (resultados.values == null) {
      return "";
    }

    return resultados.values![0][0].toString();
  }

  Future<String> rankingCampori() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!E7');

    if (resultados.values == null) {
      return "";
    }

    return resultados.values![0][0].toString();
  }

  Future<String> rankingMto() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!G4');

    if (resultados.values == null) {
      return "";
    }

    return resultados.values![0][0].toString();
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
