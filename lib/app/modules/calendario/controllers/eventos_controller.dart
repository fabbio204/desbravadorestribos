import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';

class EventoController extends NotifierStore<Exception, List<EventoModel>> {
  final CalendarioRepository _repository;

  EventoController(this._repository) : super([]);

  Future<void> init() async {
    setLoading(true);

    try {
      Future<List<EventoModel>> futureGoogleCalendario =
          _repository.calendarioCompleto();
      Future<List<EventoModel>> futureMembros = _repository.aniversariantes();

      List<List<EventoModel>> calendario = await Future.wait([
        futureGoogleCalendario,
        futureMembros,
      ]);

      List<EventoModel> eventos = [];
      eventos.addAll(calendario[0]);
      eventos.addAll(calendario[1]);

      eventos.sort((a, b) => a.dia.compareTo(b.dia));

      update(eventos);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
