// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PerfilStore on _PerfilStoreBase, Store {
  final _$pathAtom = Atom(name: '_PerfilStoreBase.path');

  @override
  String get path {
    _$pathAtom.reportRead();
    return super.path;
  }

  @override
  set path(String value) {
    _$pathAtom.reportWrite(value, super.path, () {
      super.path = value;
    });
  }

  final _$imageFileAtom = Atom(name: '_PerfilStoreBase.imageFile');

  @override
  File? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(File? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  final _$isLoadingUserAtom = Atom(name: '_PerfilStoreBase.isLoadingUser');

  @override
  bool get isLoadingUser {
    _$isLoadingUserAtom.reportRead();
    return super.isLoadingUser;
  }

  @override
  set isLoadingUser(bool value) {
    _$isLoadingUserAtom.reportWrite(value, super.isLoadingUser, () {
      super.isLoadingUser = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_PerfilStoreBase.isLoading');

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

  final _$getUserDataAsyncAction = AsyncAction('_PerfilStoreBase.getUserData');

  @override
  Future<dynamic> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  final _$getImageAsyncAction = AsyncAction('_PerfilStoreBase.getImage');

  @override
  Future<dynamic> getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  final _$resetAllImagesAsyncAction =
      AsyncAction('_PerfilStoreBase.resetAllImages');

  @override
  Future<dynamic> resetAllImages() {
    return _$resetAllImagesAsyncAction.run(() => super.resetAllImages());
  }

  final _$updateUserAsyncAction = AsyncAction('_PerfilStoreBase.updateUser');

  @override
  Future<dynamic> updateUser() {
    return _$updateUserAsyncAction.run(() => super.updateUser());
  }

  @override
  String toString() {
    return '''
path: ${path},
imageFile: ${imageFile},
isLoadingUser: ${isLoadingUser},
isLoading: ${isLoading}
    ''';
  }
}
