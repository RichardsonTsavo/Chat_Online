import 'package:flutter_test/flutter_test.dart';
import 'package:chat_system/app/modules/storys/storys_store.dart';
 
void main() {
  late StorysStore store;

  setUpAll(() {
    store = StorysStore();
  });

  test('increment count', () async {
    expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));
  });
}