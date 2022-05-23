import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
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

  Future setSubCaixa(String subCaixa) async {
    await GoogleSheetsApi.api!.spreadsheets.values.update(
        ValueRange(range: 'SubCaixas!C2', values: [
          [subCaixa]
        ]),
        GoogleSheetsApi.id,
        'SubCaixas!C2',
        valueInputOption: 'RAW');
  }

  Future<List<LancamentoModel>> lancamentos() async {
    ValueRange resultados = await GoogleSheetsApi.api!.spreadsheets.values
        .get(GoogleSheetsApi.id, 'SubCaixas!C4:G');

    if (resultados.values == null) {
      return [];
    }

    List<LancamentoModel> lista = resultados.values!.map((List<Object?> item) {
      var lancamento = LancamentoModel(
        data: item[0].toString(),
        descricao: item[1].toString(),
        entrada: item[2]?.toString(),
      );

      if (item.asMap().keys.contains(3)) {
        lancamento.saida = item[3]?.toString();
      }

      if (item.asMap().keys.contains(4)) {
        lancamento.envolvido = item[4]?.toString();
      }

      return lancamento;
    }).toList();

    return lista;
  }
}
