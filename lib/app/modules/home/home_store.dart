import 'dart:io';

import 'package:chat_system/app/shered/auth/auth_controller.dart';
import 'package:chat_system/app/shered/models/home_users_model.dart';
import 'package:chat_system/app/shered/models/story_model.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository_interface.dart';
import 'package:chat_system/app/shered/utils/snackbar/global_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  AuthController authController = Modular.get();
  GlobalSnackBar snackBar = GlobalSnackBar();
  IFirestoreRepositoryInterface _firestoreRepositoryInterface = FirestoreRepository();
  @observable
  ObservableList<HomeUsersModel> listMensages = <HomeUsersModel> [].asObservable();
  ObservableList<StoryModel> listStoreFriends = <StoryModel>[].asObservable();
  @observable
  bool isLoadingSaveFriend = false;
  @observable
  bool isLoadingSaveStory = true;
  @observable
  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  Stream<QuerySnapshot> getAllMensages(){
    return _firestoreRepositoryInterface.getAllMensagesData(myUid: authController.user!.uid);
  }
  Stream<QuerySnapshot> getAllStory(){
    return _firestoreRepositoryInterface.getAllStorys();
  }
  @action
  Future getStorys(QuerySnapshot snapshot) async{
    listStoreFriends.clear();
    if(snapshot.docs.isNotEmpty){
      List<DocumentSnapshot> list = snapshot.docs;
      for(int i = 0; i < list.length;i++){
        List<String> paths = <String>[];
        for(int j = 0;j < list[i]["paths"].length;j++){
          paths.add(list[i]["paths"][j]["path"]);
        }
        StoryModel storyModel = StoryModel(
            thumb: paths[0],
            storiesReferences: paths,
            uid: list[i].id
        );
        listStoreFriends.add(storyModel);
      }
    }
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      isLoadingSaveStory = false;
    });
  }

  @action
  Future deleteStory({required int index,required int indexStory}) async{
    isLoadingSaveStory = true;
    _firestoreRepositoryInterface.deleteStorys(id: authController.user!.uid, index: index, storyModel: listStoreFriends[indexStory]);
  }


  @action
  String returnNameUser() {
   return authController.userDocument!.userName!;
  }


  @action
  Future getImage()async{
    imageFile = null;
    final PickedFile? pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if(pickedFile == null){
      return;
    }
    imageFile = File(pickedFile.path);
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    if(croppedFile != null){
      isLoadingSaveStory = true;
     String imagePath = await _firestoreRepositoryInterface.setUploadImage(file: croppedFile);
     await _firestoreRepositoryInterface.createStory(imagePath: imagePath, uid: authController.userDocument!.userId!);
    }

  }




  @action
  Future saveFriend(int index,String uid) async{
    isLoadingSaveFriend = true;
    List listFriends = authController.userDocument!.friendsReferences!;
    listFriends.add(uid);
    HomeUsersModel homeUsersModel = listMensages[index];
    _firestoreRepositoryInterface.saveFriend(
        userModel: UserModel(
          friendsReferences: listFriends
        ),
        id: authController.user!.uid);
    authController.userDocument!.friendsReferences = listFriends;
    DocumentSnapshot data = await _firestoreRepositoryInterface.getUserWithId(id: homeUsersModel.id!);
    UserModel userData = UserModel.fromMap(data.data() as Map<String,dynamic>);
    homeUsersModel.saved = true;
    homeUsersModel.userName = userData.userName;
    listMensages.removeAt(index);
    listMensages.insert(index, homeUsersModel);
    isLoadingSaveFriend = false;
  }


  @action
  Future getMensages(QuerySnapshot snapshot) async{
    List<DocumentSnapshot> list = snapshot.docs;
    listMensages.clear();
    for(int i = 0; i < list.length;i++){
      DocumentSnapshot data = await _firestoreRepositoryInterface.getUserWithId(id: list[i].id);
      UserModel user = UserModel.fromMap(data.data() as Map<String,dynamic>);
      HomeUsersModel homeUsersModel = HomeUsersModel();
      homeUsersModel.userName = "";
      for(int j = 0; j < authController.userDocument!.friendsReferences!.length;j++){
        if(authController.userDocument!.friendsReferences![j] == list[i].id){
          homeUsersModel.userName = user.userName;
        }
      }
      if(homeUsersModel.userName == ""){
        homeUsersModel.userName = user.phone;
        homeUsersModel.saved = false;
      }else{
        homeUsersModel.saved = true;
      }
      homeUsersModel.lastMensage = list[i]["lastMensage"];
      homeUsersModel.image = user.image;
      homeUsersModel.id = list[i].id;
      listMensages.add(homeUsersModel);
    }
  }


  Future<void> logOut() async {
    authController.logOut();
  }
}