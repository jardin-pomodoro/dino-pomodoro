import 'user_entity.dart';

class AuthEntity {
  final String token;
  final UserEntity user;

  AuthEntity({
    required this.token,
    required this.user,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> map) {
    return AuthEntity(
      token: map['token'],
      user: UserEntity.fromJson(map['record']),
    );
  }
}