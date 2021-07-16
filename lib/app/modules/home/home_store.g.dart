// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$listMensagesAtom = Atom(name: 'HomeStoreBase.listMensages');

  @override
  ObservableList<HomeUsersModel> get listMensages {
    _$listMensagesAtom.reportRead();
    return super.listMensages;
  }

  @override
  set listMensages(ObservableList<HomeUsersModel> value) {
    _$listMensagesAtom.reportWrite(value, super.listMensages, () {
      super.listMensages = value;
    });
  }

  final _$isLoadingSaveFriendAtom =
      Atom(name: 'HomeStoreBase.isLoadingSaveFriend');

  @override
  bool get isLoadingSaveFriend {
    _$isLoadingSaveFriendAtom.reportRead();
    return super.isLoadingSaveFriend;
  }

  @override
  set isLoadingSaveFriend(bool value) {
    _$isLoadingSaveFriendAtom.reportWrite(value, super.isLoadingSaveFriend, () {
      super.isLoadingSaveFriend = value;
    });
  }

  final _$isLoadingSaveStoryAtom =
      Atom(name: 'HomeStoreBase.isLoadingSaveStory');

  @override
  bool get isLoadingSaveStory {
    _$isLoadingSaveStoryAtom.reportRead();
    return super.isLoadingSaveStory;
  }

  @override
  set isLoadingSaveStory(bool value) {
    _$isLoadingSaveStoryAtom.reportWrite(value, super.isLoadingSaveStory, () {
      super.isLoadingSaveStory = value;
    });
  }

  final _$imageFileAtom = Atom(name: 'HomeStoreBase.imageFile');

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

  final _$getStorysAsyncAction = AsyncAction('HomeStoreBase.getStorys');

  @override
  Future<dynamic> getStorys(QuerySnapshot<Object?> snapshot) {
    return _$getStorysAsyncAction.run(() => super.getStorys(snapshot));
  }

  final _$deleteStoryAsyncAction = AsyncAction('HomeStoreBase.deleteStory');

  @override
  Future<dynamic> deleteStory({required int index, required int indexStory}) {
    return _$deleteStoryAsyncAction
        .run(() => super.deleteStory(index: index, indexStory: indexStory));
  }

  final _$getImageAsyncAction = AsyncAction('HomeStoreBase.getImage');

  @override
  Future<dynamic> getImage() {
    return _$getImageAsyncAction.run(() => super.getImage());
  }

  final _$saveFriendAsyncAction = AsyncAction('HomeStoreBase.saveFriend');

  @override
  Future<dynamic> saveFriend(int index, String uid) {
    return _$saveFriendAsyncAction.run(() => super.saveFriend(index, uid));
  }

  final _$getMensagesAsyncAction = AsyncAction('HomeStoreBase.getMensages');

  @override
  Future<dynamic> getMensages(QuerySnapshot<Object?> snapshot) {
    return _$getMensagesAsyncAction.run(() => super.getMensages(snapshot));
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  String returnNameUser() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.returnNameUser');
    try {
      return super.returnNameUser();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listMensages: ${listMensages},
isLoadingSaveFriend: ${isLoadingSaveFriend},
isLoadingSaveStory: ${isLoadingSaveStory},
imageFile: ${imageFile}
    ''';
  }
}
