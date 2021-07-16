import 'package:flutter/material.dart';
export 'global_scaffold.dart';

class GlobalScaffold {
  static final instance = GlobalScaffold();
  final scafoldKey = GlobalKey<ScaffoldState>();
  void showSnackbar(SnackBar snackbar) {
    ScaffoldMessenger.of(scafoldKey.currentState!.context).showSnackBar(snackbar);
  }
}
