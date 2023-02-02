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
}

class UserTest {
  final String email;

  UserTest(this.email);
}
