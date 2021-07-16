import 'package:brasil_fields/brasil_fields.dart';
import 'package:chat_system/app/modules/core/core_store.dart';
import 'package:chat_system/app/shered/utils/custom_text_field_controller/custom_text_form.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DialogLoginRegister extends StatefulWidget {
  final BoxConstraints constraints;
  DialogLoginRegister({required this.constraints});
  @override
  _AlertDialogLoginState createState() => _AlertDialogLoginState();
}

class _AlertDialogLoginState extends State<DialogLoginRegister> {
  ConstStyle constStyle = ConstStyle();
  FocusNode phoneFocus = FocusNode();
  CoreStore controller = Modular.get();
  GlobalKey<FormState> registerForm = GlobalKey<FormState>();
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    BoxConstraints constraints = widget.constraints;
    return Container(
      color: Colors.transparent,
      width: constraints.maxWidth / 1.2,
      height: constraints.maxHeight / 2,
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    controller.setIndexTabLoginAlertDialog(index: 0);
                  },
                  child: Observer(
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                          color: controller.indexTabLoginAlertDialog == 0
                              ? Colors.white
                              : Colors.grey,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(5))),
                      alignment: Alignment.center,
                      child: Text(
                        "Register",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    controller.setIndexTabLoginAlertDialog(index: 1);
                  },
                  child: Observer(
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                          color: controller.indexTabLoginAlertDialog == 1
                              ? Colors.white
                              : Colors.grey,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(5))),
                      alignment: Alignment.center,
                      child: Text("Login",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                )),
              ],
            ),
          ),
          Expanded(
            flex: 80,
            child: Observer(
              builder: (context) => controller.indexTabLoginAlertDialog == 0
                  ? Form(
                      key: registerForm,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                        child: ListView(
                          children: [
                            Text(
                              "Register your acount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            /*Observer(
                              builder: (context) => TextButton(
                                  onPressed: () {
                                    controller.getImage();
                                  },
                                  child: CircleAvatar(
                                    radius: constraints.maxWidth * 0.15,
                                    child: ClipOval(
                                        child: controller.imageFile != null
                                            ? Image.file(
                                          controller.imageFile!,
                                          height: constraints.maxWidth * 0.3,
                                          width: constraints.maxWidth * 0.3,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.asset(
                                          constStyle.pathPerson,
                                          fit: BoxFit.cover,
                                        )),
                                  )),
                            ),*/
                            CustomTextFormField(
                              validator: (data) {
                                if (data!.isEmpty) {
                                  return "Enter the name";
                                }
                              },
                              initialData: "",
                              needTheSpace: true,
                              textAlign: TextAlign.start,
                              obscureText: false,
                              hint: "Name",
                              onChanged: (data) {
                                controller.registerFilds["name"] = data;
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
                              focusNode: phoneFocus,
                              initialData: "",
                              needTheSpace: true,
                              textAlign: TextAlign.start,
                              obscureText: false,
                              onChanged: (data) {
                                controller.registerFilds["phone"] = data;
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
                              initialData: "",
                              needTheSpace: true,
                              textAlign: TextAlign.start,
                              obscureText: false,
                              onChanged: (data) {
                                controller.registerFilds["email"] = data;
                              },
                              hint: "Email",
                              semanticLabel: "Email",
                              prefixIcon: Icon(
                                Icons.email,
                                color: constStyle.tertiaryColor,
                              ),
                            ),
                            Observer(
                              builder: (context) => CustomTextFormField(
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return "Enter the password";
                                  }
                                },
                                maxLines: 1,
                                initialData: "",
                                needTheSpace: true,
                                textAlign: TextAlign.start,
                                onChanged: (data) {
                                  controller.registerFilds["password"] = data;
                                },
                                hint: "Password",
                                obscureText: controller.isPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.chengePasswordVisible();
                                  },
                                  icon: Icon(
                                      controller.isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: constStyle.tertiaryColor),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: constStyle.tertiaryColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Observer(
                              builder: (context) => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize:
                                          Size(constraints.maxWidth / 6, 50),
                                      primary: constStyle.tertiaryColor),
                                  onPressed: () {
                                    if (controller.isLoading) {
                                      return;
                                    }
                                    if (registerForm.currentState!.validate()) {
                                      controller.signUp();
                                    }
                                  },
                                  child: controller.isLoading
                                      ? CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        )
                                      : Text("Register")),
                            )
                          ],
                        ),
                      ),
                    )
                  : Form(
                      key: loginForm,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        padding: EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Enter your acount",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                              CustomTextFormField(
                                validator: (data) {
                                  if (data!.isEmpty) {
                                    return "Enter the email";
                                  }
                                },
                                initialData: "",
                                needTheSpace: true,
                                textAlign: TextAlign.start,
                                obscureText: false,
                                onChanged: (data) {
                                  controller.filds["email"] = data;
                                },
                                maxLines: 1,
                                hint: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: constStyle.tertiaryColor,
                                ),
                              ),
                              Observer(
                                builder: (context) => CustomTextFormField(
                                  validator: (data) {
                                    if (data!.isEmpty) {
                                      return "Enter the password";
                                    }
                                  },
                                  maxLines: 1,
                                  initialData: "",
                                  needTheSpace: true,
                                  textAlign: TextAlign.start,
                                  onSubmited: (_) {
                                    controller.signIn();
                                  },
                                  hint: "Senha",
                                  onChanged: (data) {
                                    controller.filds["password"] = data;
                                  },
                                  obscureText: controller.isPasswordVisible,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.chengePasswordVisible();
                                    },
                                    icon: Icon(
                                      controller.isPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: constStyle.tertiaryColor,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: constStyle.tertiaryColor,
                                  ),
                                ),
                              ),
                              Observer(
                                builder: (context) => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize:
                                            Size(constraints.maxWidth / 6, 50),
                                        primary: constStyle.tertiaryColor),
                                    onPressed: () {
                                      if (loginForm.currentState!.validate()) {
                                        if (controller.isLoading) {
                                          return;
                                        }
                                        controller.signIn();
                                      }
                                    },
                                    child: controller.isLoading
                                        ? CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          )
                                        : Text("Login")),
                              )
                            ]),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
