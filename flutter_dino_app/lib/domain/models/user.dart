import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class User {
  final String collectionId;
  final String collectionName;
  final String id;
  final String username;
  final String email;
  final String avatar;
  final DateTime created;
  final DateTime updated;

  const User({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.updated,
  });

  User copyWith({
    String? username,
    String? avatar,
    String? email,
  }) {
    return User(
      collectionId: collectionId,
      collectionName: collectionName,
      created: created,
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      updated: updated,
    );
  }
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String,
      updated: DateTime.parse(json['updated'] as String),
    );
  }

  String toJson() {
    return '{'
        '"collectionId": "$collectionId",'
        '"collectionName": "$collectionName",'
        '"created": "$created",'
        '"id": "$id",'
        '"username": "$username",'
        '"email": "$email",'
        '"avatar": "$avatar",'
        '"updated": "$updated"'
        '}';
  }

  UpdateUser toUpdateUser(){
    return UpdateUser(
      username: username,
      email: email,
    );
  }
}

@immutable
class UpdateUser {
  final String username;
  final String email;

  const UpdateUser({
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap(){
    return {
      'username': username,
      'email': email,
    };
  }
}