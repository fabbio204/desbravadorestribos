import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:googleapis/calendar/v3.dart';

class CadastrarEventoController extends NotifierStore<Exception, bool> {
  final CalendarioRepository repository;
  CadastrarEventoController(this.repository) : super(false);

  Future<void> salvar(String titulo, String? descricao, DateTime data) async {
    setLoading(true);

    try {
      await repository.cadastrarEvento(Event(
        summary: titulo,
        description: descricao,
        start: EventDateTime(date: data),
        end: EventDateTime(date: data),
      ));
      update(true);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }

  Future<void> editar(
      String? id, String titulo, String? descricao, DateTime data) async {
    setLoading(true);

    try {
      await repository.editarEvento(Event(
        id: id,
        summary: titulo,
        description: descricao,
        start: EventDateTime(date: data),
        end: EventDateTime(date: data),
      ));
      update(true);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
