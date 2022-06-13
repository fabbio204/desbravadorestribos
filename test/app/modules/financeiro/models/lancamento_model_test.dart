import 'package:desbravadores_tribos/app/modules/financeiro/models/lancamento_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testa LancamentoModel', () {
    var model1 = LancamentoModel(
      data: '01/01/2022',
      descricao: 'Saldo 2021',
      subCaixa: 'Geral',
      entrada: '200',
      envolvido: '',
    );

    var model2 = model1.copyWith();

    var model3 = LancamentoModel(
      data: '01/01/2022',
      descricao: 'Saldo 2021',
      subCaixa: 'Geral',
      saida: '200',
      envolvido: '',
    );

    var model4 = LancamentoModel.fromJson(r"""
      {"data": "01/01/2022","descricao": "Saldo 2021","subCaixa": "Geral","saida": "200","envolvido": ""}""");

    expect(model1, isNotNull);
    expect(model1.saida, isNull);
    expect(true, model1 == model2);
    expect(model1, equals(model2));
    expect(model1.toString(), isNotEmpty);
    expect(model2.toJson(), isNotNull);
    expect(model3.toJson(), isNotNull);
    expect(model3.entrada, isNull);
    expect(model4.hashCode, isNot(0));
    expect(model4.dataEvento, isNotNull);
  });
}
