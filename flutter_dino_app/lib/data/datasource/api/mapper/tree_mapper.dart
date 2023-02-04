import 'package:flutter_dino_app/data/datasource/api/entity/tree_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/seed_type_expand_mapper.dart';

import '../../../../domain/models/tree.dart';

class TreeMapper {
  static Tree fromEntity(TreeEntity entity) {
    return Tree(
       collectionId: entity.collectionId,
        collectionName: entity.collectionName,
        id: entity.id,
        created: entity.created,
        updated: entity.updated,
        user: entity.user,
        seedType: entity.seedType,
        expand: SeedTypeExpandMapper.fromEntity(entity.expand),
        reward: entity.reward,
        timeToGrow: entity.timeToGrow,
        started: entity.started,
        ended: entity.ended,
    );
  }
}
