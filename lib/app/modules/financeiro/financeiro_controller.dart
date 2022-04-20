import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

class FinanceiroController extends NotifierStore<Exception, List<CaixaModel>> {
  final FinanceiroRepository repository;
  FinanceiroController(this.repository) : super([]);

  init() async {
    setLoading(true);

    try {
      List<CaixaModel> saldoCaixas = await repository.caixas();
      update(saldoCaixas);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
