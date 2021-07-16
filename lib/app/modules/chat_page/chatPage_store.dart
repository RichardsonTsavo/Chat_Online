import 'package:brasil_fields/brasil_fields.dart';
import 'package:chat_system/app/shered/auth/auth_controller.dart';
import 'package:chat_system/app/shered/models/mensage_model.dart';
import 'package:chat_system/app/shered/models/user_model.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository.dart';
import 'package:chat_system/app/shered/repositories/firestore_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

part 'chatPage_store.g.dart';

class ChatPageStore = _ChatPageStoreBase with _$ChatPageStore;
abstract class _ChatPageStoreBase with Store {
  AuthController authController = Modular.get();
  IFirestoreRepositoryInterface _firestoreRepositoryInterface = FirestoreRepository();
  ObservableList<MensageModel> listMensage = ObservableList<MensageModel>();
  @observable
  UserModel? userFriend;

  void sendMensage({required String mensage,required int order}){
    MensageModel mensageModel = MensageModel(
      mensage: mensage,
      createdAt: Timestamp.now(),
      updateAt: Timestamp.now(),
      type: 0,
      order: order,
      sender: authController.user!.uid,
      viewed: false
    );
    _firestoreRepositoryInterface.sendChatMensage(mensageModel: mensageModel, myUid: authController.user!.uid, friendUid:userFriend!.userId);
  }


  Stream<QuerySnapshot> getChatMensages(){
    return _firestoreRepositoryInterface.getChatMensages(myUid: authController.user!.uid, friendUid: userFriend!.userId);
  }


  @action
  Future getUserFriend(String uid)async{
    DocumentSnapshot data = await _firestoreRepositoryInterface.getUserWithId(id: uid);
    userFriend = UserModel.fromMap(data.data() as Map<String,dynamic>);
  }


  Future<void> makePhoneCall() async {
    String phone = UtilBrasilFields.obterTelefone(userFriend!.phone!,ddd: false,mascara: false);
    if (await canLaunch("tel:$phone")) {
      await launch("tel:$phone");
    } else {
      throw 'Could not launch $phone';
    }
  }


}