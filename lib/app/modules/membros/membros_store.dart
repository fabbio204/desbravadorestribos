import 'package:mobx/mobx.dart';

part 'membros_store.g.dart';

class MembrosStore = _MembrosStoreBase with _$MembrosStore;
abstract class _MembrosStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}