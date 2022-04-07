import 'package:mobx/mobx.dart';

part 'calendario_store.g.dart';

class CalendarioStore = _CalendarioStoreBase with _$CalendarioStore;
abstract class _CalendarioStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}