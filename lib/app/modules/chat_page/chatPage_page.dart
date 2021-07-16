import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_system/app/shered/models/mensage_model.dart';
import 'package:chat_system/app/shered/utils/custom_text_field_controller/custom_text_form.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:chat_system/app/modules/chat_page/chatPage_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPagePage extends StatefulWidget {
  final String title;
  final String uid;
  const ChatPagePage({Key? key, this.title = 'ChatPagePage', required this.uid})
      : super(key: key);
  @override
  ChatPagePageState createState() => ChatPagePageState();
}

class ChatPagePageState extends State<ChatPagePage> {
  final ChatPageStore store = Modular.get();
  ConstStyle constStyle = ConstStyle();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    store.getUserFriend(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: constStyle.primaryColor,
        appBar: AppBar(
          brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: constStyle.primaryColor,
          title: Observer(
            builder: (context) => store.userFriend == null?CircularProgressIndicator():
            Row(
              children: [
                CircleAvatar(
                  radius: constraints.maxWidth * 0.05,
                  child: ClipOval(
                      child: store.userFriend!.image != ""
                          ? Image.network(
                        store.userFriend!.image!,
                        height: constraints.maxWidth * 0.3,
                        width: constraints.maxWidth * 0.3,
                        fit: BoxFit.cover,
                      ) : Image.asset(
                        constStyle.pathPerson,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  store.userFriend!.userName!,
                  style: GoogleFonts.lato(color: Colors.white),
                  overflow: TextOverflow.fade,
                )
              ],
            ),
          ),
          actions: [
            Observer(
              builder: (context) => store.userFriend == null?CircularProgressIndicator():IconButton(
                  onPressed: store.makePhoneCall,
                  icon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  )),
            )
          ],
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            height: constraints.maxHeight * 0.9,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Observer(
              builder: (context){
                if(store.userFriend != null){
                 return StreamBuilder<QuerySnapshot>(
                    stream: store.getChatMensages(),
                    builder: (context, snapshot) {
                      if(snapshot.hasError){
                        return Center(child: Text("Error loading messages"));
                      }else if(snapshot.hasData){
                        List<DocumentSnapshot> snapshotData = snapshot.data!.docs.reversed.toList();
                        return Column(
                          children: [
                            Expanded(child: ListView.builder(
                              reverse: true,
                              itemCount: snapshotData.length,
                              itemBuilder: (context, index) {
                                MensageModel mensageModel = MensageModel.fromMap(snapshotData[index].data() as Map<String,dynamic>);
                                return mensageModel.type == 0?
                                BubbleSpecialOne(
                                  text: mensageModel.mensage!,
                                  isSender: mensageModel.sender! == store.authController.user!.uid?true:false,
                                  color: constStyle.secondaryColor,
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ):Container();
                                /*BubbleNormalAudio(
                                  color: Color(0xFFE8E8EE),
                                  duration: duration.inSeconds.toDouble(),
                                  position: position.inSeconds.toDouble(),
                                  isPlaying: isPlaying,
                                  isLoading: isLoading,
                                  isPause: isPause,
                                  onSeekChanged: _changeSeek,
                                  onPlayPauseButtonClick: _playAudio,
                                  sent: true,
                                );*/
                              },
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextFormField(
                              controller: textEditingController,
                              textAlign: TextAlign.start,
                              needTheSpace: false,
                              hint: "Write a message",
                              obscureText: false,
                              suffixIcon: IconButton(icon: Icon(Icons.send),
                                onPressed: (){
                                  if(textEditingController.text.isNotEmpty){
                                    store.sendMensage(
                                        mensage: textEditingController.text,
                                        order: snapshot.data!.docs.length
                                    );
                                    textEditingController.clear();
                                  }
                                },),
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                            )
                          ],
                        );
                      }else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  );
                }else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
