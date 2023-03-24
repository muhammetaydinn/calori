// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'item_model.dart';

class UserModel {
  String? uid;
  List<Items>? items;
  UserModel({
    this.uid,
    this.items,
  });

  

  UserModel copyWith({
    String? uid,
    List<Items>? items,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'items': items!.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      items: map['items'] != null ? List<Items>.from((map['items'] as List<int>).map<Items?>((x) => Items.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(uid: $uid, items: $items)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      listEquals(other.items, items);
  }

  @override
  int get hashCode => uid.hashCode ^ items.hashCode;
}
