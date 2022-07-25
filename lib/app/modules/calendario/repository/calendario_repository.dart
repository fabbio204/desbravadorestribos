import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:googleapis/sheets/v4.dart';

class CalendarioRepository {
  final GoogleApiBase api;

  CalendarioRepository(this.api);

  Future<List<EventoModel>> calendarioCompleto() async {
    Events resultados = await api.listarEventos(
        orderBy: 'startTime',
        timeMin: DateTime(DateTime.now().year, 1, 1),
        timeMax: DateTime(DateTime.now().year, 12, 31));

    if (resultados.items == null) {
      return [];
    }

    List<EventoModel> eventos = resultados.items!.map((Event item) {
      DateTime? data = item.start?.date ?? item.start?.dateTime;
      return EventoModel(
        id: item.id!,
        dia: data!,
        titulo: item.summary!,
        descricao: item.description,
      );
    }).toList();

    return eventos;
  }

  Future<List<EventoModel>> aniversariantes() async {
    ValueRange resultados = await api.getPlanilha('Membros!A3:D');

    if (resultados.values == null) {
      return [];
    }

    List<EventoModel> eventos = resultados.values!.map((List<Object?> item) {
      String nome = item[0].toString();
      List<String> dataLocal = item[3].toString().split('/');

      DateTime data = DateTime(
        int.parse(dataLocal[2]),
        int.parse(dataLocal[1]),
        int.parse(dataLocal[0]),
      );
      return EventoModel(dia: data, titulo: nome, descricao: 'Aniversário');
    }).toList();

    return eventos;
  }

  Future<void> cadastrarEvento(Event evento) {
    return api.cadastrarEvento(evento);
  }

  Future<void> excluirEvento(String id) {
    return api.excluirEvento(id);
  }

  Future<void> editarEvento(Event evento) {
    return api.editarEvento(evento);
  }
}
