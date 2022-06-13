import 'package:desbravadores_tribos/app/modules/calendario/models/evento_model.dart';
import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';
import 'package:desbravadores_tribos/app/modules/membros/models/membro_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HomeRepositoryMock extends Mock implements HomeRepository {}

void main() {
  group('Testa HomeController', () {
    test('Testa MembroController resultando sucesso', () async {
      var repositoryMock = HomeRepositoryMock();

      when(repositoryMock.listarAniversariantes).thenAnswer(
        (_) async => [
          MembroModel(nome: 'Mateus'),
          MembroModel(nome: 'Silas'),
        ],
      );

      when(repositoryMock.listarResumo).thenAnswer(
        (_) async => [
          ResumoModel(titulo: 'Quantidade de Membros', valor: '30'),
          ResumoModel(titulo: 'Quantidade de Desbravadores', valor: '20'),
        ],
      );

      when(repositoryMock.proximosEventos).thenAnswer(
        (_) async => [
          EventoModel(dia: DateTime(2022, 1, 1), titulo: 'Evento 1'),
          EventoModel(dia: DateTime(2022, 1, 2), titulo: 'Evento 2'),
        ],
      );

      when(repositoryMock.temNovaVersao).thenAnswer(
        (_) async => false,
      );

      var controller = HomeController(repositoryMock);

      Future<void> future = controller.init();

      expect(controller.isLoading, true);

      future.then((value) {
        expect(controller.isLoading, false);
        expect(controller.state, isNotNull);
        expect(controller.state.aniversariantes.length, equals(2));
        expect(controller.state.resumo.length, equals(2));
        expect(controller.state.eventos.length, equals(2));
        expect(controller.state.temNovaVersao, false);
      });
    });

    test('Testa HomeController recebendo erro', () async {
      var repositoryMock = HomeRepositoryMock();

      when(repositoryMock.listarAniversariantes)
          .thenThrow(Exception('Erro ao carregar os os aniversariantes'));

      var controller = HomeController(repositoryMock);

      Future<void> future = controller.init();

      future.then((value) {
        expect(controller.error, isNotNull);
      });
    });
  });
}
