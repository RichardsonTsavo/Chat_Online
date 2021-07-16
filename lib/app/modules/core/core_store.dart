import 'package:chat_system/app/shered/auth/auth_controller.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'core_store.g.dart';

class CoreStore = _CoreStoreBase with _$CoreStore;
abstract class _CoreStoreBase with Store {
  AuthController _authController = Modular.get();

  @observable
  bool isLoading = false;
  @observable
  bool isPasswordVisible = true;
  @observable
  int indexTabLoginAlertDialog = 1;

  Map<String,dynamic> recoverFilds = {};
  Map<String,dynamic> filds = {};
  Map<String,dynamic> registerFilds = {};


  @action
  void setIndexTabLoginAlertDialog({required int index}){
    indexTabLoginAlertDialog = index;
  }
  @action
  Future recoverPassword()async{
    isLoading = true;
   await  _authController.recoverPassword(
        email: recoverFilds["email"],);
    isLoading = false;
   Modular.to.pop();
  }
  @action
  Future signUp()async{
    isLoading = true;
    String path = "";
   await _authController.registerWithEmailAndPassword(
        email: registerFilds["email"],
        password: registerFilds["password"],
        userModel: UserModel(
          email: registerFilds["email"],
          phone: registerFilds["phone"],
          image: path,
          userName: registerFilds["name"],
          storiesReferences: [],
          friendsReferences: [],

        ));
    isLoading = false;
  }
  @action
  Future signIn()async{
    isLoading = true;
   await _authController.loginWithEmailAndPassword(email: filds["email"], password: filds["password"]);
    isLoading = false;
  }
  @action
  void chengePasswordVisible(){
    isPasswordVisible = !isPasswordVisible;
  }

  @action
  Future loginWithCredential() async{
    isLoading = true;
   await _authController.loginCredential();
   isLoading = false;
  }

}