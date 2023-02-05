import 'package:flutter_dino_app/data/datasource/api/entity/friendship_expand_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/user_mapper.dart';

import '../../../../domain/models/friendship_expand.dart';

class FriendshipExpandMapper {
  static FriendshipExpand fromEntity(FriendshipExpandEntity entity) {
    return FriendshipExpand(
      user: UserMapper.fromEntity(entity.userEntity),
      relation: UserMapper.fromEntity(entity.relationEntity),
    );
  }
  static FriendshipExpandEntity fromModel(FriendshipExpand model) {
    return FriendshipExpandEntity(
      userEntity: UserMapper.fromModel(model.user),
      relationEntity: UserMapper.fromModel(model.relation),
    );
  }
}
