import 'dart:convert';

class HomeUsersModel {
  String? userName;
  String? image;
  String? lastMensage;
  String?  id;
  bool?  saved;

  HomeUsersModel({
    this.userName,
    this.image,
    this.lastMensage,
    this.id,
    this.saved
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if(userName != null){
      map["userName"] = userName;
    }
    if(image != null){
      map["image"] = image;
    }
    if(lastMensage != null){
      map["lastMensage"] = lastMensage;
    }
    if(id != null){
      map["id"] = id;
    }
    return map;
  }

  factory HomeUsersModel.fromMap(Map<String, dynamic> map) {
    return HomeUsersModel(
        userName: map['userName'],
        image: map['image'],
        lastMensage: map['lastMensage'],
        id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeUsersModel.fromJson(String source) =>
      HomeUsersModel.fromMap(json.decode(source));
}
