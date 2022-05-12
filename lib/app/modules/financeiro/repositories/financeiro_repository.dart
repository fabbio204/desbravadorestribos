import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:googleapis/sheets/v4.dart';

class FinanceiroRepository {
  Future<List<CaixaModel>> saldoCaixas() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'Caixa!I4:J14');

    if (resultados.values == null) {
      return [];
    }

    List<CaixaModel> lista = resultados.values!.map((List<Object?> item) {
      return CaixaModel(nome: item[0].toString(), saldo: item[1].toString());
    }).toList();

    // Ordena pelo nome
    lista.sort((a, b) => a.nome.compareTo(b.nome));

    return lista;
  }

  Future<List<String>> subCaixas() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'SubCaixas!A1:A20');

    if (resultados.values == null) {
      return [];
    }

    List<String> lista = resultados.values!.map((List<Object?> item) {
      return item[0].toString();
    }).toList();

    // Ordena pelo nome
    lista.sort((a, b) => a.compareTo(b));

    return lista;
  }
}
