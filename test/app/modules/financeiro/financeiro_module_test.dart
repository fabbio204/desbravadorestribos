import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/repositories/financeiro_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_test/modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_module.dart';

void main() {
  setUp(() {
    initModule(FinanceiroModule());
  });

  test('Testa FinanceiroModule', () {
    final controller = Modular.get<FinanceiroController>();
    expect(controller, isNotNull);

    final repository = Modular.get<FinanceiroRepository>();
    expect(repository, isNotNull);
  });
}
