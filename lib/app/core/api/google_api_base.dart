import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';

abstract class GoogleApiBase {
  Future<ValueRange> getPlanilha(String intervalo);
  Future<void> setPlanilha(String intervalo, String valor);

  Future<Events> getEventos({
    String? orderBy,
    DateTime? timeMin,
    DateTime? timeMax,
    int maxResults = 250,
  });
}
