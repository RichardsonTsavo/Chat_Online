import 'package:chat_system/app/shered/models/story_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:chat_system/app/modules/storys/storys_store.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';

class StorysPage extends StatefulWidget {
  final String title;
  final StoryModel storys;
  final String mensage;
  const StorysPage({Key? key, this.title = 'StorysPage',required this.storys,required this.mensage}) : super(key: key);
  @override
  StorysPageState createState() => StorysPageState();
}
class StorysPageState extends State<StorysPage> {
  final StorysStore store = Modular.get();
  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = <StoryItem>[];
    for(int i = 0; i < widget.storys.storiesReferences!.length;i++){
      storyItems.add(StoryItem.pageImage(
          url: widget.storys.storiesReferences![i],
          controller: controller,
          caption: widget.mensage
      ));
    }
    return StoryView(
        storyItems: storyItems,
        controller: controller,
        repeat: false,
        onStoryShow: (s) {},
        onComplete: () {
          Modular.to.pop();
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Modular.to.pop();
          }
        }
    );
  }
}