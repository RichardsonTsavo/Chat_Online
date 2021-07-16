import 'package:chat_system/app/modules/chat_page/chatPage_Page.dart';
import 'package:chat_system/app/modules/chat_page/chatPage_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatPageModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatPageStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ChatPagePage(uid: args.data)),
  ];
}
