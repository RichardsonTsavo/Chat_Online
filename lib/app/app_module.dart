import 'package:chat_system/app/modules/chat_page/chatPage_module.dart';
import 'package:chat_system/app/modules/core/core_module.dart';
import 'package:chat_system/app/modules/home/home_module.dart';
import 'package:chat_system/app/modules/perfil/perfil_module.dart';
import 'package:chat_system/app/modules/search_user/searchUser_module.dart';
import 'package:chat_system/app/modules/storys/storys_module.dart';
import 'package:chat_system/app/shered/auth/auth_controller.dart';
import 'package:chat_system/app/shered/repositories/auth_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthRepository()),
    Bind.lazySingleton((i) => AuthController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: CoreModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/chat", module: ChatPageModule()),
    ModuleRoute("/perfil", module: PerfilModule()),
    ModuleRoute("/storys", module: StorysModule()),
    ModuleRoute("/search", module: SearchUserModule()),
  ];

}