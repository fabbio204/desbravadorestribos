import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/membros/membros_store.dart';
 
void main() {
  late MembrosStore store;

  setUpAll(() {
    store = MembrosStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}