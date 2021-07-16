import 'package:chat_system/app/shered/utils/custom_text_field_controller/custom_text_form.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:chat_system/app/modules/search_user/searchUser_store.dart';
import 'package:flutter/material.dart';

class SearchUserPage extends StatefulWidget {
  final String title;
  const SearchUserPage({Key? key, this.title = 'SearchUserPage'}) : super(key: key);
  @override
  SearchUserPageState createState() => SearchUserPageState();
}
class SearchUserPageState extends State<SearchUserPage> {
  final SearchUserStore store = Modular.get();
  ConstStyle constStyle = ConstStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomTextFormField(
          textAlign: TextAlign.start,
          needTheSpace: false,
          hint: "Search by user name",
          initialData: "",
          obscureText: false,
          suffixIcon: Icon(Icons.search),
          onChanged: store.setSetFilter,
          maxLines: 1,
          keyboardType: TextInputType.text,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: store.allUsers(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text("Error loading users"),);
          }else if(snapshot.hasData){
            store.setAllUsers(snapshot.data!);
            return Observer(
              builder: (context) => ListView.builder(
                itemCount: store.listfilteredUsers.length,
                itemBuilder: (context, index) =>
                    ListTile(
                      onTap: (){
                        Modular.to.pushNamed("/chat",arguments: store.listfilteredUsers[index].userId);
                      },
                      leading: CircleAvatar(
                        child: ClipOval(
                          child: store.listfilteredUsers[index].image! != ""
                              ? Image.network(
                            store.listfilteredUsers[index].image!,
                            fit: BoxFit.cover,
                          ) : Image.asset(
                            constStyle.pathPerson,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(store.listfilteredUsers[index].userName!),
                    ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}