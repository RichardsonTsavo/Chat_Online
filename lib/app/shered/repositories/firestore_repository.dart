import 'dart:io';

import 'package:chat_system/app/shered/models/mensage_model.dart';
import 'package:chat_system/app/shered/models/story_model.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreRepository implements IFirestoreRepositoryInterface {
  @override
    Stream<QuerySnapshot> getChatMensages({required String myUid,required friendUid}) {
      return FirebaseFirestore.instance
        .collection("Users").doc(myUid).collection("chats").doc(friendUid).collection("mensages").orderBy("order").snapshots();
    }

  @override
  Future updateSeenMensage({required MensageModel mensage,required String myUid,required friendUid}) async{
  return await FirebaseFirestore.instance
        .collection("Users").doc(friendUid).collection("chats").doc(myUid).collection("mensages").doc(mensage.id).update(mensage.toMap());
  }

  @override
  Future sendChatMensage({required MensageModel mensageModel,required String myUid,required friendUid}) async{
   String uid = DateTime.now().millisecondsSinceEpoch.toString();
   mensageModel.id = uid;
     FirebaseFirestore.instance
        .collection("Users").doc(myUid).collection("chats").doc(friendUid).collection("mensages").doc(uid).set(mensageModel.toMap());
     FirebaseFirestore.instance
       .collection("Users").doc(myUid).collection("chats").doc(friendUid).set({
        "lastMensage":mensageModel.mensage
      });
     FirebaseFirestore.instance
       .collection("Users").doc(friendUid).collection("chats").doc(myUid).collection("mensages").doc(uid).set(mensageModel.toMap());
     FirebaseFirestore.instance
       .collection("Users").doc(friendUid).collection("chats").doc(myUid).set({
     "lastMensage":mensageModel.mensage
   });
  }

  @override
  Future createUser({required UserModel userModel, required User user}) async{
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  @override
  Future<void> deleteMedia({required String path}) async{
   return await FirebaseStorage.instance
        .refFromURL(path).delete();
  }

  @override
  Future deleteMensageForAll({required String mensageUid,required String myUid,required friendUid}) async{
    await FirebaseFirestore.instance
        .collection("Users").doc(friendUid).collection(myUid).doc(mensageUid).delete();
    await FirebaseFirestore.instance
        .collection("Users").doc(myUid).collection(friendUid).doc(mensageUid).delete();
  }

  @override
  Future deleteMensageForMe({required String mensageUid, required String myUid}) async{
   return await FirebaseFirestore.instance
        .collection("Users").doc(myUid).collection(myUid).doc(mensageUid).delete();
  }

  @override
  Future<DocumentSnapshot<Object?>> getUserDocumentData({required User user}) async{
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();
  }

  @override
  Future recoverPassword({required String email}) async{
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future setError({required String error, required String module}) {
    return FirebaseFirestore.instance
        .collection("Error").doc(DateTime.now().millisecondsSinceEpoch.toString()).set({
      "erro": error,
      "date": Timestamp.fromDate(DateTime.now()),
      "module":module
    });
  }

  @override
  Future setUpdateUser({required UserModel userModel}) {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel.userId)
        .update(userModel.toMap());
  }

  @override
  Future setUploadImage({required File file}) async{
    FirebaseStorage storage = FirebaseStorage.instance;
    final FirebaseStorage feedStorage = FirebaseStorage.instanceFor(bucket: storage.bucket);

    Reference refFeedBucket = feedStorage
        .ref()
        .child("images").child(DateTime.now().millisecondsSinceEpoch.toString());

    String downloadUrl = "";

    TaskSnapshot uploadedFile = await refFeedBucket.putFile(file);

    if (uploadedFile.state == TaskState.success) {
      downloadUrl = await refFeedBucket.getDownloadURL();
    }

    return downloadUrl;
    }

  @override
  Stream<QuerySnapshot<Object?>> getAllUsersData() {
    return FirebaseFirestore.instance
        .collection("Users").snapshots();
  }
  @override
  Stream<QuerySnapshot<Object?>> getAllMensagesData({required String myUid}) {
    return FirebaseFirestore.instance
        .collection("Users").doc(myUid).collection("chats").snapshots();
  }

  @override
  Future<DocumentSnapshot<Object?>> getUserWithId({required String id}) {
    return FirebaseFirestore.instance
        .collection("Users").doc(id).get();
  }
  @override
  Future saveFriend({required UserModel userModel,required String id}) {
    return FirebaseFirestore.instance
        .collection("Users").doc(id).update(userModel.toMap());
  }

  @override
  Future createStory({required String imagePath,required String uid}) async{
    Map<String,dynamic> newStory = {
      "dateCreation": Timestamp.now(),
      "path":imagePath
    };
    List<Map<String,dynamic>> paths = [];
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Storys").doc(uid).get();
    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      for(int i = 0; i < data["paths"].length;i++){
        paths.add(data["paths"][i]);
      }
    }
    paths.add(newStory);
    return await FirebaseFirestore.instance
        .collection("Storys")
        .doc(uid)
        .set({
          "paths":paths,
        });
  }

  @override
  Stream<QuerySnapshot<Object?>> getAllStorys() {
    return FirebaseFirestore.instance
        .collection("Storys").snapshots();
  }

  @override
  Future deleteStorys({required String id,required int index,required StoryModel storyModel}) async{
    List<Map<String,dynamic>> paths = [];
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Storys").doc(id).get();
    if(snapshot.exists){
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      for(int i = 0; i < data["paths"].length;i++){
        paths.add(data["paths"][i]);
      }
    }
    deleteMedia(path: storyModel.storiesReferences![index]);
    paths.removeAt(index);
    if(paths.isNotEmpty){
      return await FirebaseFirestore.instance
          .collection("Storys").doc(id).update({"paths":paths});
    }else{
      return await FirebaseFirestore.instance
          .collection("Storys").doc(id).delete();
    }

  }

}
