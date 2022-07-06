import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:googleapis/calendar/v3.dart';

class CadastrarEventoController extends NotifierStore<Exception, bool> {
  final CalendarioRepository repository;
  CadastrarEventoController(this.repository) : super(false);

  Future<void> salvar(String titulo, DateTime data) async {
    setLoading(true);

    try {
      await repository.cadastrarEvento(Event(
        summary: titulo,
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
