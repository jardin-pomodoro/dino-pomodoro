import 'user_entity.dart';

class AuthEntity {
  final String token;
  final Map<String, dynamic> authModel;
  final UserEntity user;

  AuthEntity({
    required this.token,
    required this.authModel,
    required this.user,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> map) {
    return AuthEntity(
      authModel: map['record'],
      token: map['token'],
      user: UserEntity.fromJson(map['record']),
    );
  }
}
