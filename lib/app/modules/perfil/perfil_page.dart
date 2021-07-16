import 'package:brasil_fields/brasil_fields.dart';
import 'package:chat_system/app/shered/utils/custom_text_field_controller/custom_text_form.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:chat_system/app/modules/perfil/perfil_store.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  final String title;
  const PerfilPage({Key? key, this.title = 'Perfil'}) : super(key: key);
  @override
  PerfilPageState createState() => PerfilPageState();
}

class PerfilPageState extends State<PerfilPage> {
  final PerfilStore store = Modular.get();

  @override
  void initState() {
    store.getUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ConstStyle constStyle = ConstStyle();
    GlobalKey<FormState> form = GlobalKey<FormState>();
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Observer(
          builder: (context) => store.isLoadingUser?Center(child: CircularProgressIndicator(),):Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Observer(
                      builder: (context) => TextButton(
                        onPressed: () {
                          if(store.path != ""){
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Select an option"),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Select an option"),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: (){
                                                        Modular.to.pop();
                                                      },
                                                      child: Text("Voltar")
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: (){
                                                        store.resetAllImages();
                                                        Modular.to.pop();
                                                        Modular.to.pop();
                                                      },
                                                      child: Text("Resetar")
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("Remove your photo")
                                    ),
                                    ElevatedButton(
                                        onPressed: (){
                                          store.getImage();
                                        },
                                        child: Text("change photo")
                                    )
                                  ],
                                ),
                              ),
                            );
                          }else{
                            store.getImage();
                          }
                        },
                        child: CircleAvatar(
                            radius: constraints.maxWidth * 0.15,
                            child: store.path == ""?ClipOval(
                                child: store.imageFile != null
                                    ? Image.file(
                                  store.imageFile!,
                                  height: constraints.maxWidth * 0.3,
                                  width: constraints.maxWidth * 0.3,
                                  fit: BoxFit.cover,
                                ) : Image.asset(
                                  constStyle.pathPerson,
                                  fit: BoxFit.cover,
                                )):ClipOval(
                              child: store.imageFile != null
                                  ? Image.file(
                                store.imageFile!,
                                height: constraints.maxWidth * 0.3,
                                width: constraints.maxWidth * 0.3,
                                fit: BoxFit.cover,
                              ) : Image.network(
                                store.authController.userDocument!.image!,
                                fit: BoxFit.cover,
                              ),
                            )),
                      )),
                  Column(
                    children: [
                      CustomTextFormField(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "Enter the name";
                          }
                        },
                        initialData: store.authController.userDocument!.userName!,
                        needTheSpace: true,
                        textAlign: TextAlign.start,
                        obscureText: false,
                        hint: "Name",
                        onChanged: (data) {
                          store.filds["name"] = data;
                        },
                        prefixIcon: Icon(
                          Icons.person,
                          color: constStyle.tertiaryColor,
                        ),
                        maxLines: 1,
                      ),
                      CustomTextFormField(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "Enter the phone";
                          }
                        },
                        keyboardType: TextInputType.number,
                        initialData: store.authController.userDocument!.phone!,
                        needTheSpace: true,
                        textAlign: TextAlign.start,
                        obscureText: false,
                        onChanged: (data) {
                          store.filds["phone"] = data;
                        },
                        hint: "Phone",
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        prefixIcon: Icon(
                          Icons.phone_android,
                          color: constStyle.tertiaryColor,
                        ),
                      ),
                      CustomTextFormField(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "Enter the email";
                          }
                        },
                        initialData: store.authController.userDocument!.email!,
                        needTheSpace: true,
                        textAlign: TextAlign.start,
                        obscureText: false,
                        onChanged: (data) {
                          store.filds["email"] = data;
                        },
                        hint: "Email",
                        semanticLabel: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          color: constStyle.tertiaryColor,
                        ),
                      ),
                    ],
                  ),
                  Observer(
                    builder: (context) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                            Size(constraints.maxWidth / 6, 50),
                            primary: constStyle.tertiaryColor),
                        onPressed: () {
                          if (store.isLoading) {
                            return;
                          }
                          if (form.currentState!.validate()) {
                            store.updateUser();
                          }
                        },
                        child: store.isLoading
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Colors.white),
                        )
                            : Text("Update")),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
