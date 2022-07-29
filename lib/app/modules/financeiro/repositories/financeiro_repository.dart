import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:googleapis/sheets/v4.dart';

class FinanceiroRepository {
  final GoogleApiBase api;

  FinanceiroRepository(this.api);

  Future<List<CaixaModel>> saldoCaixas() async {
    ValueRange resultados = await api.getPlanilha('Caixa!I4:J14');

    if (resultados.values == null) {
      return [];
    }

    List<CaixaModel> lista = resultados.values!.map((List<Object?> item) {
      return CaixaModel(nome: item[0].toString(), saldo: item[1].toString());
    }).toList();

    return lista;
  }

  Future<List<String>> subCaixas() async {
    ValueRange resultados = await api.getPlanilha('SubCaixas!A1:A20');

    if (resultados.values == null) {
      return [];
    }

    List<String> lista = resultados.values!.map((List<Object?> item) {
      return item[0].toString();
    }).toList();

    // Ordena em ordem alfabética
    lista.sort((a, b) => a.compareTo(b));

    return lista;
  }

  Future<List<LancamentoModel>> lancamentos() async {
    int rowInicial = 7;
    ValueRange resultados = await api.getPlanilha('Caixa!A$rowInicial:F');

    if (resultados.values == null) {
      return [];
    }

    List<LancamentoModel> lista = resultados.values!
        .asMap()
        .entries
        .map((MapEntry<int, List<Object?>> e) {
      int index = e.key + rowInicial;
      List<Object?> item = e.value;
      LancamentoModel lancamento = LancamentoModel(
          id: index,
          data: item[0].toString(),
          descricao: item[1].toString(),
          entrada: item[2]?.toString(),
          subCaixa: item[4]?.toString());

      Iterable<int> posicoes = item.asMap().keys;
      if (posicoes.contains(3)) {
        lancamento.saida = item[3]?.toString();
      }

      if (posicoes.contains(5)) {
        lancamento.envolvido = item[5]?.toString();
      }

      return lancamento;
    }).toList();

    return lista;
  }

  Future<int> quantidadeLinhas() async {
    int linhaInicial = 7;
    ValueRange linhas = await api.getPlanilha('Caixa!A$linhaInicial:A');
    return linhaInicial - 1 + linhas.values!.length;
  }

  Future<void> cadastrarLancamento(LancamentoModel model) async {
    int quantidade = await quantidadeLinhas();
    quantidade++;
    await api.setPlanilhaConjunto('Caixa!A$quantidade:F$quantidade', [
      [
        model.data,
        model.descricao,
        model.entrada ?? '',
        model.saida ?? '',
        model.subCaixa ?? '',
        model.envolvido ?? '',
      ],
    ]);
  }

  Future<void> editarLancamento(LancamentoModel model) async {
    int linha = model.id!;
    await api.setPlanilhaConjunto('Caixa!A$linha:F$linha', [
      [
        model.data,
        model.descricao,
        model.entrada ?? '',
        model.saida ?? '',
        model.subCaixa ?? '',
        model.envolvido ?? '',
      ],
    ]);
  }
}
