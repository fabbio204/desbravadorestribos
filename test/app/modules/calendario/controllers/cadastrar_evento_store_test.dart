import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/calendario/controllers/cadastrar_evento_store.dart';

void main() {
  late CadastrarEventoController store;

  setUpAll(() {
    store = CadastrarEventoController();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}
