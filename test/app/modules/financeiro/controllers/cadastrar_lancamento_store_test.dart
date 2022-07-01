import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/controllers/cadastrar_lancamento_store.dart';
 
void main() {
  late CadastrarLancamentoStore store;

  setUpAll(() {
    store = CadastrarLancamentoStore();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}