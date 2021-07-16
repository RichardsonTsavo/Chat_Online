// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatPage_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatPageStore on _ChatPageStoreBase, Store {
  final _$userFriendAtom = Atom(name: '_ChatPageStoreBase.userFriend');

  @override
  UserModel? get userFriend {
    _$userFriendAtom.reportRead();
    return super.userFriend;
  }

  @override
  set userFriend(UserModel? value) {
    _$userFriendAtom.reportWrite(value, super.userFriend, () {
      super.userFriend = value;
    });
  }

  final _$getUserFriendAsyncAction =
      AsyncAction('_ChatPageStoreBase.getUserFriend');

  @override
  Future<dynamic> getUserFriend(String uid) {
    return _$getUserFriendAsyncAction.run(() => super.getUserFriend(uid));
  }

  @override
  String toString() {
    return '''
userFriend: ${userFriend}
    ''';
  }
}
