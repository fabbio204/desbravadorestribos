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
      model.subCaixas = await repository.subCaixas();
      update(model);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<List<LancamentoModel>> setSubCaixa(String subCaixa) async {
    await repository.setSubCaixa(subCaixa);
    return await repository.lancamentos();
  }
}
