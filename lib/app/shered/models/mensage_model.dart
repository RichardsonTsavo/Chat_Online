import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MensageModel {
  String? id;
  String? mensage;
  String? sender;
  int? type;
  int? order;
  bool? viewed;
  Timestamp? createdAt;
  Timestamp? updateAt;

  MensageModel({
    this.id,
    this.mensage,
    this.sender,
    this.type,
    this.order,
    this.viewed,
    this.createdAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if(id != null){
      map["id"] = id;
    }
    if(mensage != null){
      map["mensage"] = mensage;
    }
    if(sender != null){
      map["sender"] = sender;
    }
    if(type != null){
      map["type"] = type;
    }
    if(order != null){
      map["order"] = order;
    }
    if(viewed != null){
      map["viewed"] = viewed;
    }
    if(createdAt != null){
      map["createdAt"] = createdAt;
    }
    if(updateAt != null){
      map["updateAt"] = updateAt;
    }
    return map;
  }

  factory MensageModel.fromMap(Map<String, dynamic> map) {
    return MensageModel(
      viewed: map['viewed'],
      mensage: map['mensage'],
      sender: map['sender'],
      order: map['order'],
      type: map['type'],
      createdAt: map['createdAt'],
      updateAt: map['updateAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MensageModel.fromJson(String source) =>
      MensageModel.fromMap(json.decode(source));
}
