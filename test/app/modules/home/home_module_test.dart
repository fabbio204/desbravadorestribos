import 'package:desbravadores_tribos/app/modules/home/controllers/home_controller.dart';
import 'package:desbravadores_tribos/app/modules/home/home_module.dart';
import 'package:desbravadores_tribos/app/modules/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  setUp(() {
    initModule(HomeModule());
  });
  test('Testa HomeModule', () {
    final titulo = Modular.get<ValueNotifier<String>>();
    expect(titulo.value, 'Início');

    final controller = Modular.get<HomeController>();
    expect(controller, isNotNull);

    final repository = Modular.get<HomeRepository>();
    expect(repository, isNotNull);
  });
}
