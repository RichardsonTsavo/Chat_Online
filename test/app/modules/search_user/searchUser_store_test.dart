import 'package:flutter_test/flutter_test.dart';
import 'package:chat_system/app/modules/search_user/searchUser_store.dart';
 
void main() {
  late SearchUserStore store;

  setUpAll(() {
    store = SearchUserStore();
  });

  test('increment count', () async {
    /*expect(store.value, equals(0));
    store.increment();
    expect(store.value, equals(1));*/
  });
}