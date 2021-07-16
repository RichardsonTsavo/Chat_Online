import 'dart:convert';

class UserModel {
  String? userName;
  String? phone;
  String? image;
  String? email;
  String? userId;
  List<dynamic>? storiesReferences;
  List<dynamic>? friendsReferences;

  UserModel({
    this.userName,
    this.phone,
    this.image,
    this.email,
    this.userId,
    this.storiesReferences,
    this.friendsReferences
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if(userName != null){
      map["userName"] = userName;
    }
    if(phone != null){
      map["phone"] = phone;
    }
    if(image != null){
      map["image"] = image;
    }
    if(email != null){
      map["email"] = email;
    }
    if(userId != null){
      map["userId"] = userId;
    }
    if(storiesReferences != null){
      map["storiesReferences"] = storiesReferences;
    }
    if(friendsReferences != null){
      map["friendsReferences"] = friendsReferences;
    }
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'],
      phone: map['phone'],
      image: map['image'],
      email: map['email'],
      userId: map['userId'],
      storiesReferences: map['storiesReferences'],
      friendsReferences: map['friendsReferences']
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
