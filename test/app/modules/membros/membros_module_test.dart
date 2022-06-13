import 'package:desbravadores_tribos/app/modules/membros/membro_controller.dart';
import 'package:desbravadores_tribos/app/modules/membros/repositories/membro_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_module.dart';


void main() {
  setUp(() {
    initModule(MembrosModule());
  });

  test('Testa MembrosModule', () {
    final repository = Modular.get<MembroRepository>();
    expect(repository, isNotNull);

    final controller = Modular.get<MembroController>();
    expect(controller, isNotNull);
  });
}
