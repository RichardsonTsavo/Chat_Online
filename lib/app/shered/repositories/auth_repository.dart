import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/auth_repository_interface.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements IAuthRepository {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  IFirestoreRepositoryInterface _firestoreRepository = FirestoreRepository();

  @override
  Future getLogout() async {
    return _firebaseAuth.signOut();
  }

  @override
  Future<User> setEmailEndPasswordLogin(
      {required String email,
      required String password,
      required UserModel userModel}) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    userModel.userId = user!.uid;
    await _firestoreRepository.createUser(user: user, userModel: userModel);
    return user;
  }

  @override
  Future setUpdateUser({required UserModel userModel}) async {
    return await _firestoreRepository.setUpdateUser(userModel: userModel);
  }

  @override
  Future<DocumentSnapshot> getUserData({required User user}) async {
    return await _firestoreRepository.getUserDocumentData(user: user);
  }

  /*@override
  Future<bool> getIsAdmin({required String id}) async {
    return await _firestoreRepository.getAdmin(id: id);
  }*/

  @override
  Future recoverPassword({required String email}) async {
    return await _firestoreRepository.recoverPassword(email: email);
  }

  @override
  Future getEmailEndPasswordLogin({required String email, required String password}) async {
    UserCredential value = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return value.user;
  }

  @override
  Future<User> getUser() async {
    return _firebaseAuth.currentUser!;
  }
}
