import 'package:flutter_test/flutter_test.dart';
import 'package:desbravadores_tribos/app/modules/financeiro/financeiro_controller.dart';
 
void main() {
  late FinanceiroController store;

  setUpAll(() {
    store = FinanceiroController();
  });

  test('increment count', () async {
    expect(store.state, equals(0));
    store.update(store.state + 1);
    expect(store.state, equals(1));
  });
}