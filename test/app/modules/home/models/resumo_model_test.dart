import 'package:desbravadores_tribos/app/modules/home/models/resumo_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testa ResumoModel', () {
    ResumoModel model = ResumoModel(titulo: 'Teste 1', valor: 'Valor Teste');

    expect(model.titulo, isNotNull);
    expect(model.valor, isNotNull);
  });
}
