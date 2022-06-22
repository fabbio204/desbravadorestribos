import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/controllers/membro_detalhes_controller.dart';

void main() {
  late MembroDetalhesController store;

  setUpAll(() {
    store = MembroDetalhesController();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}
