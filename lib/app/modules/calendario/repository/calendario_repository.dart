import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:googleapis/calendar/v3.dart';

class CalendarioRepository {
  final GoogleApiBase api;

  CalendarioRepository(this.api);

  Future<List<EventoModel>> calendarioCompleto() async {
    Events resultados = await api.getEventos(
        orderBy: 'startTime',
        timeMin: DateTime(DateTime.now().year, 1, 1),
        timeMax: DateTime(DateTime.now().year, 12, 31));

    if (resultados.items == null) {
      return [];
    }

    List<EventoModel> aniversariantes = resultados.items!.map((Event item) {
      DateTime? data = item.start?.date ?? item.start?.dateTime;
      return EventoModel(dia: data!, titulo: item.summary!);
    }).toList();

    aniversariantes.sort((a, b) => a.dia.compareTo(b.dia));

    return aniversariantes;
  }
}
