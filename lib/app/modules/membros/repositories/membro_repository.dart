import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:googleapis/sheets/v4.dart';

class MembroRepository {
  final GoogleApiBase api;

  MembroRepository(this.api);
  Future<List<MembroModel>> listar() async {
    ValueRange resultados = await api.getPlanilha('Membros!A3:F100');

    if (resultados.values == null) {
      return [];
    }

    List<MembroModel> membros = resultados.values!.map((List<Object?> item) {
      return MembroModel(
        nome: item[0].toString(),
        unidade: item[2].toString(),
        aniversario: item[3].toString(),
        foto: item[4].toString(),
        idade: int.parse(item[5].toString()),
      );
    }).toList();

    membros.sort(((a, b) => a.nome.compareTo(b.nome)));

    return membros;
  }

  Future<List<LancamentoModel>> listarLancamentos(String nome) async {
    await api.setPlanilha('Caixa!L7', nome);

    ValueRange resultados = await api.getPlanilha('Caixa!L9:N');

    if (resultados.values == null) {
      return [];
    }

    List<LancamentoModel> lista = resultados.values!.map((List<Object?> item) {
      var lancamento = LancamentoModel(
          data: item[0].toString(),
          descricao: item[1].toString(),
          entrada: item[2]?.toString(),
          subCaixa: "");

      return lancamento;
    }).toList();

    // Ordena pelo nome
    lista.sort((a, b) => b.dataEvento.compareTo(a.dataEvento));

    return lista;
  }
}
