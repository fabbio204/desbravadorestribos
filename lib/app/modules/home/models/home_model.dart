import 'package:desbravadores_tribos/app/core/models/aniversariante_model.dart';
import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';

class HomeModel {
  List<ResumoModel> resumo = [];
  List<AniversarianteModel> aniversariantes = [];
  List<EventoModel> eventos = [];
}

class ResumoTitulo {
  static String get membros => "Membros";
  static String get inscricoesCampori => "Inscrições do Campori";
  static String get saldoCaixa => "Saldo em Caixa";
  static String get rankingCampori => "Ranking do Campori";
  static String get rankingMto => "Ranking da MTO";
}
