import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';

abstract class GoogleApiBase {
  Future<ValueRange> getPlanilha(String intervalo);
  Future<void> setPlanilha(String intervalo, String valor);
  Future<void> setPlanilhaConjunto(String intervalo, List<List<Object>> valor);

  Future<Events> listarEventos({
    String? orderBy,
    DateTime? timeMin,
    DateTime? timeMax,
    int maxResults = 250,
  });

  Future<void> cadastrarEvento(Event evento);

  Future<void> excluirEvento(String id);

  Future<void> editarEvento(Event evento);
}
