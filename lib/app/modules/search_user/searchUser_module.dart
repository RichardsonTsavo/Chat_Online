import 'package:chat_system/app/modules/search_user/searchUser_Page.dart';
import 'package:chat_system/app/modules/search_user/searchUser_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchUserModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SearchUserStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SearchUserPage()),
  ];
}
