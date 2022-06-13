import 'package:desbravadores_tribos/app/modules/home/models/home_model.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';

class HomeController extends NotifierStore<Exception, HomeModel> {
  final HomeRepository repository;

  HomeController(this.repository) : super(HomeModel());

  Future<void> init() async {
    setLoading(true);
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

      update(model);
    } on Exception catch (e) {
      setError(e);
    } finally {
      setLoading(false);
    }
  }
}
