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
  final int balance;
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
    required this.balance,
    required this.updated,
  });

  User copyWith({
    String? username,
    String? avatar,
    String? email,
    int? balance,
  }) {
    return User(
      collectionId: collectionId,
      collectionName: collectionName,
      created: created,
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      balance: balance ?? this.balance,
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
      balance: json['balance'] as int,
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
        '"balance": $balance,'
        '"updated": "$updated"'
        '}';
  }

  UpdateUser toUpdateUser(){
    return UpdateUser(
      username: username,
      email: email,
      balance: balance,
    );
  }
}

@immutable
class UpdateUser {
  final String username;
  final String email;
  final int balance;

  const UpdateUser({
    required this.username,
    required this.email,
    required this.balance,
  });

  Map<String, dynamic> toMap(){
    return {
      'username': username,
      'email': email,
      'balance': balance,
    };
  }
}