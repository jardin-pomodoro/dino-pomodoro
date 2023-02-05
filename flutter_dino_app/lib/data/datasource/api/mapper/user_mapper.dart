import 'package:flutter_dino_app/domain/models/user.dart';

import '../entity/user_entity.dart';
import '../pocketbase.dart';

class UserMapper {
  static User fromEntity(UserEntity entity) {
    return User(
      collectionId: entity.collectionId,
      collectionName: entity.collectionName,
      id: entity.id,
      username: entity.username,
      email: entity.email,
      avatar: ApiPocketBase.collectionFileUrl(
          entity.collectionId, entity.id, entity.avatar),
      created: entity.created,
      updated: entity.updated,
      balance: entity.balance,
    );
  }
}
