import 'package:desbravadores_tribos/app/core/api/google_sheets_api.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:googleapis/calendar/v3.dart';

class CalendarioRepository {
  Future<List<EventoModel>> calendarioCompleto() async {
    Events resultados = await GoogleSheetsApi.calendarApi!.events.list(
        GoogleSheetsApi.idCalendario,
        orderBy: 'startTime',
        singleEvents: true,
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
