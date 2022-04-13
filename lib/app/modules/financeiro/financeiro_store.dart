import 'package:mobx/mobx.dart';

part 'financeiro_store.g.dart';

class FinanceiroStore = _FinanceiroStoreBase with _$FinanceiroStore;
abstract class _FinanceiroStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}