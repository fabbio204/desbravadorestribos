import 'package:desbravadores_tribos/app/modules/home/models/home_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final HomeModel model;

  HomeLoadedState(this.model);
}

class HomeErrorState extends HomeState {
  final Exception e;
  HomeErrorState(this.e);

  String get mensagem => e.toString();
}
