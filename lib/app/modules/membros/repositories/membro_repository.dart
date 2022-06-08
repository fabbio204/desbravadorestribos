import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:googleapis/sheets/v4.dart';

class MembroRepository {
  Future<List<MembroModel>> listar() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Membros!A3:F100');

    if (resultados.values == null) {
      return [];
    }

    List<MembroModel> membros = resultados.values!.map((List<Object?> item) {
      return MembroModel(
          nome: item[0].toString(),
          unidade: item[2].toString(),
          aniversario: item[3].toString(),
          foto: item[4].toString(),
          idade: int.parse(item[5].toString()));
    }).toList();

    return membros;
  }
}
