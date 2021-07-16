import 'package:chat_system/app/modules/core/core_store.dart';
import 'package:chat_system/app/shered/utils/custom_text_field_controller/custom_text_form.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AlertDialogRecoverPassword extends StatefulWidget {
  final BoxConstraints constraints;
  AlertDialogRecoverPassword({required this.constraints});
  @override
  _AlertDialogRecoverPasswordState createState() =>
      _AlertDialogRecoverPasswordState();
}

class _AlertDialogRecoverPasswordState
    extends ModularState<AlertDialogRecoverPassword,CoreStore> {
  ConstStyle constStyle = ConstStyle();
  GlobalKey<FormState> recoverForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    BoxConstraints constraints = widget.constraints;
    return AlertDialog(
      content: Form(
        key: recoverForm,
        child: Container(
            color: Colors.white,
            width: constraints.maxWidth / 1.2,
            height: constraints.maxHeight / 3,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Recover your password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  CustomTextFormField(
                    validator: (data) {
                      if(data!.isEmpty){
                        return "Enter the email";
                      }
                    },
                    maxLines: 1,
                    initialData: "",
                    needTheSpace: true,
                    textAlign: TextAlign.start,
                    obscureText: false,
                    onChanged: (data){
                      controller.recoverFilds["email"] = data;
                    },
                    hint: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: constStyle.tertiaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Observer(
                    builder: (context) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(constraints.maxWidth / 6, 50),
                            primary: constStyle.tertiaryColor),
                        onPressed: () {
                          if(recoverForm.currentState!.validate()){
                            controller.recoverPassword();
                          }
                        },
                        child: controller.isLoading
                            ? CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation(Colors.white),
                        )
                            : Text("Submit request")),
                  )
                ])),
      ),
    );
  }
}
