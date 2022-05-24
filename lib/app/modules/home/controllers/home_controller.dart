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

      // Rodando todas as consultas em paralelo
      await Future.wait<void>([
        (() async => repository
            .listarAniversariantes()
            .then((value) => model.aniversariantes = value))(),
        (() async => repository
            .proximosEventos()
            .then((value) => model.eventos = value))(),
        (() async =>
            repository.listarResumo().then((value) => model.resumo = value))(),
        (() async => repository
            .temNovaVersao()
            .then((value) => model.temNovaVersao = value))(),
      ]);
      HomeLoadedState state = HomeLoadedState(model);
      value = state;
    } on Exception catch (e) {
      value = HomeErrorState(e);
    }
  }
}
