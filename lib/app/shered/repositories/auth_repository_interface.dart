import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<User> getUser();
 // Future<bool> getIsAdmin({required String id});
  Future getLogout();
  Future recoverPassword({required String email});
  Future getEmailEndPasswordLogin({required String email, required String password});
  Future setEmailEndPasswordLogin({required String email, required String password, required UserModel userModel});
  Future<DocumentSnapshot> getUserData({required User user});
  Future setUpdateUser({required UserModel userModel});
}
