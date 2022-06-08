import 'package:desbravadores_tribos/app/modules/financeiro/models/caixa_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Teta CaixaModel', () {
    var model1 = CaixaModel(nome: 'Geral', lancamentos: [], saldo: '0,00');

    var model2 = model1.copyWith();

    var model3 = CaixaModel(
      nome: "Geral",
      saldo: "0,00",
    );

    var model4 = CaixaModel.fromJson(r"""
      {
        "nome": "Geral",
        "lancamentos": [],
        "saldo": "0,00"
      }
    """);

    expect(model1, isNotNull);
    expect(model1.lancamentos, isNotNull);
    expect(true, model1 == model2);
    expect(model1, equals(model2));
    expect(model1.toString(), isNotEmpty);
    expect(model2.toJson(), isNotNull);
    expect(model3.toJson(), isNotNull);
    expect(model3.lancamentos, isNull);
    expect(model4.hashCode, isNot(0));
  });
}
