import 'package:chat_system/app/shered/utils/snackbar/global_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Chat Online',
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(
        key: GlobalScaffold.instance.scafoldKey,
        body: child,
        resizeToAvoidBottomInset: false,
      ),
    ).modular();
  }
}