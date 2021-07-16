import 'package:flutter_test/flutter_test.dart';
import 'package:chat_system/app/modules/chat_page/chatPage_store.dart';
 
void main() {
  late ChatPageStore store;

  setUpAll(() {
    store = ChatPageStore();
  });

  test('increment count', () async {
    /*expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));*/
  });
}