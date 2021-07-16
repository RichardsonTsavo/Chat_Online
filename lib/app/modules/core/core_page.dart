import 'package:chat_system/app/modules/core/components/alert_dialog_recover_password.dart';
import 'package:chat_system/app/modules/core/components/dialog_login_register.dart';
import 'package:chat_system/app/shered/utils/style/style.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:chat_system/app/modules/core/core_store.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CorePage extends StatefulWidget {
  final String title;
  const CorePage({Key? key, this.title = 'CorePage'}) : super(key: key);
  @override
  CorePageState createState() => CorePageState();
}

class CorePageState extends State<CorePage> {
  final CoreStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.loginWithCredential();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  Widget build(BuildContext context) {
    ConstStyle constStyle = ConstStyle();
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: constStyle.primaryColor,
        body: SingleChildScrollView(
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Logo",
                  style:
                  GoogleFonts.pacifico(fontSize: constraints.maxWidth*0.2,color: Colors.white),
                ),
                DialogLoginRegister(constraints: constraints),
                TextButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialogRecoverPassword(constraints: constraints,),);
                    },
                    child: Text("Recover Password",style:
                    GoogleFonts.lato(color: Colors.white,
                        fontWeight: FontWeight.bold,fontSize: constraints.maxWidth*0.04),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
