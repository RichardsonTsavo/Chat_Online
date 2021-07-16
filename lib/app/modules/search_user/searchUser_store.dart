import 'package:chat_system/app/shered/auth/auth_controller.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'searchUser_store.g.dart';

class SearchUserStore = _SearchUserStoreBase with _$SearchUserStore;
abstract class _SearchUserStoreBase with Store {
  AuthController _authController = Modular.get();
  IFirestoreRepositoryInterface _firestoreRepositoryInterface = FirestoreRepository();
  ObservableList<UserModel> listAllUsers = <UserModel>[].asObservable();
  ObservableList<UserModel> listfilteredUsers = <UserModel>[].asObservable();

  Stream<QuerySnapshot> allUsers() {
    return _firestoreRepositoryInterface.getAllUsersData();
  }

  @action
  void setAllUsers(QuerySnapshot snapshot) {
    listAllUsers.clear();
    listfilteredUsers.clear();
    print(snapshot.docs.length);
    for(int i = 0; i < snapshot.docs.length;i++){
      if(_authController.user!.uid != snapshot.docs[i].id){
        listAllUsers.add(UserModel.fromMap(snapshot.docs[i].data() as Map<String,dynamic>));
      }
    }
    listfilteredUsers.addAll(listAllUsers);
  }

  @action
  void setSetFilter(String filter) {
    listfilteredUsers.clear();
    listfilteredUsers.addAll(listAllUsers.where((element) => element.userName!.toLowerCase().contains(filter.toLowerCase())));
  }

}