import '../../../../domain/models/user_auth.dart';

import '../entity/auth_entity.dart';
import 'user_mapper.dart';

class AuthMapper {
  static UserAuth fromEntity(AuthEntity entity) {
    return UserAuth(
      authModel: entity.authModel,
      token: entity.token,
      user: UserMapper.fromEntity(entity.user),
    );
  }
}
