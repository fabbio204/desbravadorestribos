import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

class MembroController extends NotifierStore<Exception, List<MembroModel>> {
  final MembroRepository repository;
  MembroController(this.repository) : super([]);

  Future<void> init() async {
    setLoading(true);

    try {
      List<MembroModel> membros = await repository.listar();
      update(membros);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
