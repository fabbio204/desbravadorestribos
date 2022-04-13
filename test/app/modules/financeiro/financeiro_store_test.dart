import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_store.dart';
 
void main() {
  late FinanceiroStore store;

  setUpAll(() {
    store = FinanceiroStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}