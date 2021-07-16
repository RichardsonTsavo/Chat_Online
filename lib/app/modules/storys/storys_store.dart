import 'package:mobx/mobx.dart';

part 'storys_store.g.dart';

class StorysStore = _StorysStoreBase with _$StorysStore;
abstract class _StorysStoreBase with Store {

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  } 
}