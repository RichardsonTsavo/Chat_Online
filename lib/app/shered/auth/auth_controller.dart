import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/auth_repository_interface.dart';
import 'package:chat_system/app/shered/repositories/shared_preferences_repository.dart';
import 'package:chat_system/app/shered/utils/snackbar/global_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthController with _$AuthController;

abstract class _AuthController with Store {
  IAuthRepository _authRepository = Modular.get();
  SharedPreferencesRepository _sharedPreferencesRepository = SharedPreferencesRepository();
  GlobalSnackBar snackBar = GlobalSnackBar();
  UserModel? userDocument;
  bool isAdmin = false;
  @observable
  User? user;

  @action
  setUser(User value) => user = value;

  _AuthController() {
    _authRepository.getUser().then(setUser);
  }

  @action
  Future recoverPassword({required String email}) async {
    try{
      await _authRepository.recoverPassword(email: email);
      snackBar.showSucessSnackbar("request sent successfully");
    }catch(onError){
      snackBar.showErrorSnackbar(onError.toString());
    }
    
  }

  @action
  Future registerWithEmailAndPassword(
      {required String email,
      required String password,
      required UserModel userModel}) async {
    user = await _authRepository.setEmailEndPasswordLogin(
        email: email, password: password, userModel: userModel);
   DocumentSnapshot data = await _authRepository.getUserData(user: user!);
    final Map <String, dynamic> doc = data.data() as Map<String, dynamic>;
   userDocument = UserModel.fromMap(doc);
    _sharedPreferencesRepository.save(key: "Credentials", item: <String>[
      email,
      password,
    ]);
    Modular.to.pushReplacementNamed("/home");
    //isAdmin = await authRepository.getIsAdmin(id: userDocument.id);
  }

  @action
  Future loginCredential() async {
    try{
      List<String> dataCredentials = await _sharedPreferencesRepository.getInfo(key: "Credentials");
      user = await _authRepository.getEmailEndPasswordLogin(email: dataCredentials[0], password: dataCredentials[1],);
      DocumentSnapshot data = await _authRepository.getUserData(user: user!);
      final Map <String, dynamic> doc = data.data() as Map<String, dynamic>;
      userDocument = UserModel.fromMap(doc);
      Modular.to.pushReplacementNamed("/home");
    }catch (onError){
      print(onError);
    }

  }


  @action
  Future loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try{
      user = await _authRepository.getEmailEndPasswordLogin(email: email, password: password);
      DocumentSnapshot data = await _authRepository.getUserData(user: user!);
      final Map <String, dynamic> doc = data.data() as Map<String, dynamic>;
      userDocument = UserModel.fromMap(doc);
      _sharedPreferencesRepository.save(key: "Credentials", item: <String>[
        email,
        password,
      ]);
      Modular.to.pushReplacementNamed("/home");
    }catch(onError){
      snackBar.showErrorSnackbar(onError.toString());
    }
  }

  @action
  Future setUpdateUser({required UserModel userModel}) async {
    return await _authRepository.setUpdateUser(userModel: userModel);
  }

  Future logOut() async {
    _sharedPreferencesRepository.deleteInfo();
    Modular.to.pushNamedAndRemoveUntil("/", ModalRoute.withName('/'));
    return _authRepository.getLogout();
  }
}
