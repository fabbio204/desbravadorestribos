import 'package:desbravadores_tribos/app/modules/home/models/home_model.dart';
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
      model.resumo = await repository.listarResumo();

      HomeLoadedState state = HomeLoadedState(model);
      value = state;
    } on Exception catch (e) {
      value = HomeErrorState(e);
    }
  }
}
