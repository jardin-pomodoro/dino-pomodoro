import 'package:flutter_dino_app/data/datasource/api/mapper/friendship_expand_mapper.dart';

import '../../../../domain/models/friendship.dart';
import '../entity/friendship_entity.dart';

class FriendshipMapper {
  static Friendship fromEntity(FriendshipEntity entity) {
    return Friendship(
      id: entity.id,
      user: entity.user,
      relation: entity.relation,
      collectionId: entity.collectionId,
      collectionName: entity.collectionName,
      status: entity.status,
      created: entity.created,
      updated: entity.updated,
      expand: FriendshipExpandMapper.fromEntity(entity.expand),
    );
  }

  static FriendshipEntity fromModel(Friendship model) {
    return FriendshipEntity(
      id: model.id,
      user: model.user,
      relation: model.relation,
      collectionId: model.collectionId,
      collectionName: model.collectionName,
      status: model.status,
      created: model.created,
      updated: model.updated,
      expand: FriendshipExpandMapper.fromModel(model.expand),
    );
  }
}
