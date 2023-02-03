import 'package:flutter/material.dart';

import 'user.dart';

@immutable
class UserAuth {
  final String token;
  final User user;

  const UserAuth({
    required this.token,
    required this.user,
  });

  UserAuth copyWith({
    String? username,
    String? avatar,
    String? email,
  }) {
    return UserAuth(
      token: token,
      user: user.copyWith(
        username: username,
        avatar: avatar,
        email: email,
      ),
    );
  }
}