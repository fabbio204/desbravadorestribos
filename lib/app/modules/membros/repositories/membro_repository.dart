import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:googleapis/sheets/v4.dart';

class MembroRepository {
  Future<List<MembroModel>> listar() async {
    ValueRange resultados = await GoogleSheetsApi
        .planilhaApi!.spreadsheets.values
        .get(GoogleSheetsApi.idPlanilha, 'Membros!A3:F100');

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

    membros.sort(((a, b) => a.nome.compareTo(b.nome)));

    return membros;
  }
}
