import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:desbravadores_tribos/app/modules/calendario/repository/calendario_repository.dart';

class EventoController extends NotifierStore<Exception, List<EventoModel>> {
  final CalendarioRepository _repository;

  EventoController(this._repository) : super([]);

  Future<void> init() async {
    setLoading(true);

    try {
      List<EventoModel> calendario = await _repository.calendarioCompleto();
      update(calendario);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
