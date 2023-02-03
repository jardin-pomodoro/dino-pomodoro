import 'package:flutter_dino_app/domain/models/user_auth.dart';

import '../entity/auth_entity.dart';
import 'user_mapper.dart';

class AuthMapper {
  static UserAuth fromEntity(AuthEntity entity) {
    return UserAuth(
      token: entity.token,
      user: UserMapper.fromEntity(entity.user),
    );
  }
}
