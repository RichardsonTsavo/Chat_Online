// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthController, Store {
  final _$userAtom = Atom(name: '_AuthController.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$recoverPasswordAsyncAction =
      AsyncAction('_AuthController.recoverPassword');

  @override
  Future<dynamic> recoverPassword({required String email}) {
    return _$recoverPasswordAsyncAction
        .run(() => super.recoverPassword(email: email));
  }

  final _$registerWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthController.registerWithEmailAndPassword');

  @override
  Future<dynamic> registerWithEmailAndPassword(
      {required String email,
      required String password,
      required UserModel userModel}) {
    return _$registerWithEmailAndPasswordAsyncAction.run(() => super
        .registerWithEmailAndPassword(
            email: email, password: password, userModel: userModel));
  }

  final _$loginCredentialAsyncAction =
      AsyncAction('_AuthController.loginCredential');

  @override
  Future<dynamic> loginCredential() {
    return _$loginCredentialAsyncAction.run(() => super.loginCredential());
  }

  final _$loginWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthController.loginWithEmailAndPassword');

  @override
  Future<dynamic> loginWithEmailAndPassword(
      {required String email, required String password}) {
    return _$loginWithEmailAndPasswordAsyncAction.run(() =>
        super.loginWithEmailAndPassword(email: email, password: password));
  }

  final _$setUpdateUserAsyncAction =
      AsyncAction('_AuthController.setUpdateUser');

  @override
  Future<dynamic> setUpdateUser({required UserModel userModel}) {
    return _$setUpdateUserAsyncAction
        .run(() => super.setUpdateUser(userModel: userModel));
  }

  final _$_AuthControllerActionController =
      ActionController(name: '_AuthController');

  @override
  dynamic setUser(User value) {
    final _$actionInfo = _$_AuthControllerActionController.startAction(
        name: '_AuthController.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
