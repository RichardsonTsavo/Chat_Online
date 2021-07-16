import 'package:chat_system/app/modules/home/home_store.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_story_list/flutter_story_list.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore store = HomeStore();
  ConstStyle constStyle = ConstStyle();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: constStyle.primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          elevation: 0,
          title: Text(
            "Olá: " + store.returnNameUser(),
            style: GoogleFonts.lato(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: store.logOut,
                icon: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                )),
            PopupMenuButton(
              icon: Icon(Icons.settings),
              onSelected: (value) {
                switch (value) {
                  case 0:
                    Modular.to.pushNamed("/perfil");
                    break;
                  case 1:
                    Modular.to.pushNamed("/about");
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Perfil"),
                  value: 0,
                ),
                PopupMenuItem(
                  child: Text("About"),
                  value: 1,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add),
          onPressed: (){
            Modular.to.pushNamed("/search");
          },
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.2,
                child: StreamBuilder<QuerySnapshot>(
                  stream: store.getAllStory(),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text("Erro to load story"));
                    }else if(snapshot.hasData){
                      store.getStorys(snapshot.data!);
                      return Observer(
                        builder: (context) => StoryList(
                          height: constraints.maxHeight * 0.2,
                          iconBackgroundColor: constStyle.secondaryColor,
                          borderColor: Colors.transparent,
                          onPressedIcon: () {
                            store.getImage();
                          },
                          image: store.authController.userDocument!.image != ""
                              ? Image.network(
                            store.authController.userDocument!.image!,
                            fit: BoxFit.cover,
                          ) : Image.asset(
                            constStyle.pathPerson,
                            fit: BoxFit.cover,
                          ),
                          text: Text(
                            "Create Story",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                          itemCount: store.listStoreFriends.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: (){
                              if(store.isLoadingSaveStory){
                                store.snackBar.showErrorSnackbar("Please wait for the loading to finish!");
                                return;
                              }
                              Modular.to.pushNamed("/storys",
                               arguments: {
                                "storys": store.listStoreFriends[index],
                                "mensage":""
                              });
                            },
                            onLongPress: (){
                              if(store.listStoreFriends[index].uid != store.authController.user!.uid){
                                store.snackBar.showErrorSnackbar("this story is not yours");
                                return;
                              }
                              if(store.isLoadingSaveStory){
                                store.snackBar.showErrorSnackbar("Please wait for the loading to finish!");
                                return;
                              }
                              showDialog(context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Deletar Story"),
                                    content: Container(
                                      height: constraints.maxHeight/2,
                                      width: constraints.maxWidth,
                                      child: ListView.separated(
                                          itemBuilder: (context, i) => ListTile(
                                            leading: CircleAvatar(
                                                radius: constraints.maxWidth * 0.15,
                                                child: ClipOval(
                                                    child: Image.network(
                                                      store.listStoreFriends[index].storiesReferences![i],
                                                      fit: BoxFit.cover,
                                                    ))),
                                            title: Text("Image: ${i+1}"),
                                            onTap: (){
                                              showDialog(context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text("Delete Story"),
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        ElevatedButton(onPressed: (){
                                                          Modular.to.pop();
                                                        }, child: Text("Não")),
                                                      ElevatedButton(onPressed: (){
                                                        Modular.to.pop();
                                                        Modular.to.pop();
                                                        store.deleteStory(index: i, indexStory: index);
                                                      }, child: Text("Sim"))
                                                  ],
                                                )
                                                ),
                                              );
                                            },
                                          ),
                                          separatorBuilder: (context, index) {
                                            return Divider();
                                          },
                                          itemCount: store.listStoreFriends[index].storiesReferences!.length
                                      ),
                                    ),
                                  ),
                              );
                            },
                            child: Image.network(
                              store.listStoreFriends[index].thumb!,
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
              Observer(
                builder: (BuildContext context) => store.isLoadingSaveStory?
                    Padding(padding: EdgeInsets.only(bottom: 10),child: LinearProgressIndicator(),)
                    :SizedBox(),
              ),
              Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: StreamBuilder<QuerySnapshot>(
                  stream: store.getAllMensages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Erro"),
                      );
                    } else if (snapshot.hasData) {
                      store.getMensages(snapshot.data!);
                      return Observer(
                        builder: (context) => ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: store.listMensages.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: ListTile(
                              onTap: () {
                                Modular.to.pushNamed("/chat",
                                    arguments: store.listMensages[index].id);
                              },
                              leading: CircleAvatar(
                                radius: constraints.maxWidth * 0.05,
                                child: ClipOval(
                                    child: store.listMensages[index].image != ""
                                        ? Image.network(
                                      store.listMensages[index].image!,
                                      height: constraints.maxWidth * 0.3,
                                      width: constraints.maxWidth * 0.3,
                                      fit: BoxFit.cover,
                                    )
                                        : Image.asset(
                                      constStyle.pathPerson,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              trailing: store.listMensages[index].saved == true
                                  ? SizedBox()
                                  : store.isLoadingSaveFriend?
                              CircularProgressIndicator()
                                  :IconButton(
                                onPressed: () {
                                  store.saveFriend(index,store.listMensages[index].id!);
                                },
                                icon: Icon(Icons.save),
                              ),
                              title: Text(store.listMensages[index].userName!),
                              subtitle:
                              Text(store.listMensages[index].lastMensage!),
                            ),
                          ),
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
