import 'dart:convert';

class StoryModel {
  String? uid;
  String? thumb;
  List<String>? storiesReferences;

  StoryModel({
    this.thumb,
    this.storiesReferences,
    this.uid
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if(storiesReferences != null){
      map["storiesReferences"] = storiesReferences;
    }
    if(storiesReferences != null){
      map["storiesReferences"] = storiesReferences;
    }
    return map;
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
        storiesReferences: map['storiesReferences'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source));
}
