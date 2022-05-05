import 'package:desbravadores_tribos/app/core/api/app_version.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeRepository {
  Future<List<MembroModel>> listarAniversariantes() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Dashboard!A12:C21');

    if (resultados.values == null) {
      return [];
    }

    List<MembroModel> aniversariantes =
        resultados.values!.map((List<Object?> item) {
      return MembroModel(
          aniversario: item[1].toString(),
          nome: item[2].toString(),
          foto: item[0].toString());
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

  Future<bool> temNovaVersao() async {
    String versaoRecente = await AppVersion().releaseVersion();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versaoInstalada = packageInfo.version;

    return versaoRecente != versaoInstalada;
  }
}
