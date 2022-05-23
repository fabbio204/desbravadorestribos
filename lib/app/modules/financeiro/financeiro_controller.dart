import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/financeiro_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

class FinanceiroController extends NotifierStore<Exception, FinanceiroModel> {
  final FinanceiroRepository repository;
  FinanceiroController(this.repository) : super(FinanceiroModel());

  init() async {
    setLoading(true);

    try {
      FinanceiroModel model = FinanceiroModel();
      model.saldoCaixas = await repository.saldoCaixas();

      model.lancamentos = await repository.lancamentos();

      for (var x in model.saldoCaixas) {
        x.lancamentos = await getLancamentos(x.nome, model.lancamentos);
      }

      model.saldoCaixas.insert(
          0,
          CaixaModel(
            nome: 'Todos',
            lancamentos: model.lancamentos,
          ));

      update(model);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  getLancamentos(String nome, List<LancamentoModel> lancamentos) {
    var lista =
        lancamentos.where((element) => element.subCaixa == nome).toList();
    lista.sort((a, b) => b.dataEvento.compareTo(a.dataEvento));

    return lista;
  }
}
