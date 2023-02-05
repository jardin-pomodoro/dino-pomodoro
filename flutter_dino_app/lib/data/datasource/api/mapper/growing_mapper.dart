import 'package:flutter_dino_app/data/datasource/api/entity/growing_entity.dart';
import 'package:flutter_dino_app/data/datasource/api/mapper/seed_type_expand_mapper.dart';
import 'package:flutter_dino_app/domain/models/growing.dart';

class GrowingMapper {
  static Growing fromEntity(GrowingEntity entity) {
    return Growing(
      id: entity.id,
      created: entity.created,
      updated: entity.updated,
      collectionId: entity.collectionId,
      collectionName: entity.collectionName,
      seedType: entity.seedType,
      user: entity.user,
      expand: SeedTypeExpandMapper.fromEntity(entity.expand),
      reward: entity.reward,
      timeToGrow: entity.timeToGrow,
    );
  }
}
