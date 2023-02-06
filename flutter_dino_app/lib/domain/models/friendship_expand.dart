import 'package:flutter/material.dart';
import 'package:garden_pomodoro/domain/models/user.dart';

@immutable
class FriendshipExpand {
  final User user;
  final User relation;

  const FriendshipExpand({required this.user, required this.relation});

  factory FriendshipExpand.fromJson(Map<String, dynamic> json) {
    return FriendshipExpand(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      relation: User.fromJson(json['relation'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'relation': relation.toJson(),
    };
  }
}
