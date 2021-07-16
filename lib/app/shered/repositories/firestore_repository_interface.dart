import 'dart:io';

import 'package:chat_system/app/shered/models/mensage_model.dart';
import 'package:chat_system/app/shered/models/story_model.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirestoreRepositoryInterface {
  Future<DocumentSnapshot> getUserDocumentData({required User user});
  Future<DocumentSnapshot> getUserWithId({required String id});
  Future recoverPassword({required String email});
  Future setUpdateUser({required UserModel userModel});
  Future setUploadImage({required File file});
  Future createUser({required UserModel userModel, required User user});
  Future<void> deleteMedia({required String path});
  Future deleteMensageForAll({required String mensageUid,required String myUid,required friendUid});
  Future deleteMensageForMe({required String mensageUid,required String myUid,});
  Future setError({required String error,required String module,});
  Future sendChatMensage({required MensageModel mensageModel,required String myUid,required friendUid});
  Future updateSeenMensage({required MensageModel mensage,required String myUid,required friendUid});
  Future saveFriend({required UserModel userModel,required String id});
  Future createStory({required String imagePath,required String uid});
  Future deleteStorys({required String id,required int index,required StoryModel storyModel});
  Stream<QuerySnapshot> getChatMensages({required String myUid,required friendUid});
  Stream<QuerySnapshot> getAllMensagesData({required String myUid});
  Stream<QuerySnapshot> getAllUsersData();
  Stream<QuerySnapshot> getAllStorys();
}
