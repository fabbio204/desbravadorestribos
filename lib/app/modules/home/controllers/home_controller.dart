import 'package:desbravadores_tribos/app/modules/home/models/home_model.dart';
import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:flutter/material.dart';

import 'package:desbravadores_tribos/app/modules/home/models/home_state.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';

class HomeController extends ValueNotifier<HomeState> {
  final HomeRepository repository;

  HomeController(this.repository) : super(HomeInitialState());

  Future carregar() async {
    value = HomeLoadingState();
    try {
      HomeModel model = HomeModel();
      model.aniversariantes = await repository.listarAniversariantes();
      model.eventos = await repository.proximosEventos();

      model.resumo.add(ResumoModel(
          titulo: ResumoTitulo.membros,
          valor: await repository.quantidadeMembros()));

      model.resumo.add(ResumoModel(
          titulo: ResumoTitulo.rankingCampori,
          valor: await repository.rankingCampori()));

      model.resumo.add(ResumoModel(
          titulo: ResumoTitulo.saldoCaixa,
          valor: await repository.saldoCaixa()));

      model.resumo.add(ResumoModel(
          titulo: ResumoTitulo.inscricoesCampori,
          valor: await repository.inscricoesCampori()));

      model.resumo.add(ResumoModel(
          titulo: ResumoTitulo.rankingMto,
          valor: await repository.rankingMto()));

      HomeLoadedState state = HomeLoadedState(model);
      value = state;
    } on Exception catch (e) {
      value = HomeErrorState(e);
    }
  }
}
