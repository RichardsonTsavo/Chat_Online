import 'package:chat_system/app/modules/storys/storys_Page.dart';
import 'package:chat_system/app/modules/storys/storys_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StorysModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StorysStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => StorysPage(mensage: args.data["mensage"],storys: args.data["storys"],)),
  ];
}
