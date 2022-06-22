import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

class MembroDetalhesController
    extends NotifierStore<Exception, List<LancamentoModel>> {
  final MembroRepository repository;
  MembroDetalhesController(this.repository) : super([]);

  Future<void> listarLancamentos(String nome) async {
    setLoading(true);

    try {
      List<LancamentoModel> lancamentos =
          await repository.listarLancamentos(nome);

      update(lancamentos);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
