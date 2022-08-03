import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

class CadastrarLancamentoStore extends NotifierStore<Exception, bool> {
  final FinanceiroRepository repository;

  CadastrarLancamentoStore(this.repository) : super(false);

  Future<void> cadastrar(LancamentoModel model) async {
    setLoading(true);

    try {
      await repository.cadastrarLancamento(model);
      update(true);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> editar(LancamentoModel model) async {
    setLoading(true);

    try {
      await repository.editarLancamento(model);
      update(true);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
