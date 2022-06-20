import 'package:desbravadores_tribos/app/core/api/app_version.dart';
import 'package:desbravadores_tribos/app/core/api/google_api_base.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:dio/dio.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeRepository {
  final GoogleApiBase api;
  final Dio dio;

  HomeRepository(this.api, this.dio);

  Future<List<MembroModel>> listarAniversariantes() async {
    ValueRange resultados = await api.getPlanilha('Dashboard!A12:C21');

    if (resultados.values == null) {
      return [];
    }

    List<MembroModel> aniversariantes =
        resultados.values!.map((List<Object?> item) {
      return MembroModel(
          aniversario: item[1].toString(),
          nome: item[2].toString(),
          foto: item[0].toString());
    }).toList();

    return aniversariantes;
  }

  Future<List<ResumoModel>> listarResumo() async {
    ValueRange resultados = await api.getPlanilha('Dashboard!C2:D8');

    if (resultados.values == null) {
      return [];
    }

    List<ResumoModel> resumo = resultados.values!.map((List<Object?> item) {
      return ResumoModel(titulo: item[0].toString(), valor: item[1].toString());
    }).toList();

    return resumo;
  }

  Future<List<EventoModel>> proximosEventos() async {
    DateTime agora = DateTime.now();
    DateTime ontem = DateTime(agora.year, agora.month, agora.day).toUtc();

    Events resultados = await api.getEventos(
      timeMin: ontem,
      orderBy: 'startTime',
      maxResults: 10,
    );

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

  Future<bool> temNovaVersao() async {
    String versaoRecente = await AppVersion(dio).releaseVersion();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versaoInstalada = packageInfo.version;

    return versaoRecente != versaoInstalada;
  }
}
