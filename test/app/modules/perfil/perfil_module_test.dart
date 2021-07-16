import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_system/app/modules/perfil/perfil_module.dart';
 
void main() {

  setUpAll(() {
    initModule(PerfilModule());
  });
}