import 'dart:io';

import 'package:chat_system/app/shered/auth/auth_controller.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository_interface.dart';
import 'package:chat_system/app/shered/utils/snackbar/global_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'perfil_store.g.dart';

class PerfilStore = _PerfilStoreBase with _$PerfilStore;
abstract class _PerfilStoreBase with Store {
  AuthController authController = Modular.get();
  IFirestoreRepositoryInterface _firestoreRepositoryInterface = FirestoreRepository();
  GlobalSnackBar snackBar = GlobalSnackBar();
  @observable
  String path = "";
  @observable
  File? imageFile;
  @observable
  bool isLoadingUser = true;
  @observable
  bool isLoading = false;
  final ImagePicker _picker = ImagePicker();
  Map<String,dynamic> filds = {};

  @action
  Future getUserData() async{
    DocumentSnapshot data = await _firestoreRepositoryInterface.getUserDocumentData(user: authController.user!);
    authController.userDocument = UserModel.fromMap(data.data() as Map<String,dynamic>);
    filds["name"] = authController.userDocument!.userName!;
    filds["phone"] = authController.userDocument!.phone!;
    filds["email"] = authController.userDocument!.email!;
    path = authController.userDocument!.image!;
    isLoadingUser = false;
  }


  @action
  Future getImage()async{
    imageFile = null;
    final PickedFile? pickedFile = await _picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile!.path);
  }

  @action
  Future resetAllImages() async{
    isLoading = true;
    try{
      if(path != ""){
        await _firestoreRepositoryInterface.deleteMedia(path: path);
      }
      path = "";
      imageFile = null;
      _firestoreRepositoryInterface.setUpdateUser(userModel: UserModel(
        userId: authController.userDocument!.userId!,
        image: path,
      ));
      snackBar.showErrorSnackbar("Imagem removida com sucesso");
    }catch(onError){
      snackBar.showErrorSnackbar(onError.toString());
    }
    isLoading = false;
  }


  @action
  Future updateUser() async{
    isLoading = true;
    try{
      if(path != ""){
        await _firestoreRepositoryInterface.deleteMedia(path: path);
      }
      if(imageFile != null){
        path = await _firestoreRepositoryInterface.setUploadImage(file: imageFile!);
      }
      _firestoreRepositoryInterface.setUpdateUser(userModel: UserModel(
        userName:filds["name"],
        email: filds["email"],
        phone: filds["phone"],
        userId: authController.userDocument!.userId!,
        image: path,
      ));
      snackBar.showErrorSnackbar("Informações atualizadas com sucesso");
    }catch(onError){
      snackBar.showErrorSnackbar(onError.toString());
    }
    isLoading = false;
  }

}