import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/calendario/calendario_store.dart';
 
void main() {
  late CalendarioStore store;

  setUpAll(() {
    store = CalendarioStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}