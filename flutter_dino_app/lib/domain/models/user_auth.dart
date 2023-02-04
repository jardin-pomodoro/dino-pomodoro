import 'dart:convert';

import 'package:flutter/material.dart';

import 'user.dart';

@immutable
class UserAuth {
  final String token;
  final Map<String, dynamic> authModel;
  final User user;

  const UserAuth({
    required this.token,
    required this.user,
    required this.authModel,
  });

  UserAuth copyWith({
    String? username,
    String? avatar,
    String? email,
  }) {
    return UserAuth(
      authModel: authModel,
      token: token,
      user: user.copyWith(
        username: username,
        avatar: avatar,
        email: email,
      ),
    );
  }

  String toJson() {
    return json.encode({
      'authModel': authModel,
      'token': token,
      'user': user.toJson(),
    });
  }

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      authModel: json['authModel'],
      token: json['token'] as String,
      user: User.fromJson(jsonDecode(json['user'])),
    );
  }
}
