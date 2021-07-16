// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CoreStore on _CoreStoreBase, Store {
  final _$isLoadingAtom = Atom(name: '_CoreStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isPasswordVisibleAtom =
      Atom(name: '_CoreStoreBase.isPasswordVisible');

  @override
  bool get isPasswordVisible {
    _$isPasswordVisibleAtom.reportRead();
    return super.isPasswordVisible;
  }

  @override
  set isPasswordVisible(bool value) {
    _$isPasswordVisibleAtom.reportWrite(value, super.isPasswordVisible, () {
      super.isPasswordVisible = value;
    });
  }

  final _$indexTabLoginAlertDialogAtom =
      Atom(name: '_CoreStoreBase.indexTabLoginAlertDialog');

  @override
  int get indexTabLoginAlertDialog {
    _$indexTabLoginAlertDialogAtom.reportRead();
    return super.indexTabLoginAlertDialog;
  }

  @override
  set indexTabLoginAlertDialog(int value) {
    _$indexTabLoginAlertDialogAtom
        .reportWrite(value, super.indexTabLoginAlertDialog, () {
      super.indexTabLoginAlertDialog = value;
    });
  }

  final _$recoverPasswordAsyncAction =
      AsyncAction('_CoreStoreBase.recoverPassword');

  @override
  Future<dynamic> recoverPassword() {
    return _$recoverPasswordAsyncAction.run(() => super.recoverPassword());
  }

  final _$signUpAsyncAction = AsyncAction('_CoreStoreBase.signUp');

  @override
  Future<dynamic> signUp() {
    return _$signUpAsyncAction.run(() => super.signUp());
  }

  final _$signInAsyncAction = AsyncAction('_CoreStoreBase.signIn');

  @override
  Future<dynamic> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  final _$loginWithCredentialAsyncAction =
      AsyncAction('_CoreStoreBase.loginWithCredential');

  @override
  Future<dynamic> loginWithCredential() {
    return _$loginWithCredentialAsyncAction
        .run(() => super.loginWithCredential());
  }

  final _$_CoreStoreBaseActionController =
      ActionController(name: '_CoreStoreBase');

  @override
  void setIndexTabLoginAlertDialog({required int index}) {
    final _$actionInfo = _$_CoreStoreBaseActionController.startAction(
        name: '_CoreStoreBase.setIndexTabLoginAlertDialog');
    try {
      return super.setIndexTabLoginAlertDialog(index: index);
    } finally {
      _$_CoreStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void chengePasswordVisible() {
    final _$actionInfo = _$_CoreStoreBaseActionController.startAction(
        name: '_CoreStoreBase.chengePasswordVisible');
    try {
      return super.chengePasswordVisible();
    } finally {
      _$_CoreStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isPasswordVisible: ${isPasswordVisible},
indexTabLoginAlertDialog: ${indexTabLoginAlertDialog}
    ''';
  }
}
