import 'package:flutter_dino_app/data/datasource/api/entity/seed_type_entity.dart';

import '../../../../domain/models/seed_type.dart';

class SeedTypeMapper {
  static SeedType fromEntity(SeedTypeEntity entity) {
    return SeedType(
      collectionId: entity.collectionId,
      collectionName: entity.collectionName,
      id: entity.id,
      name: entity.name,
      image: entity.image,
      timeToGrow: entity.timeToGrow,
      price: entity.price,
      reward: entity.reward,
      leafMaxUpgrades: entity.leafMaxUpgrades,
      trunkMaxUpgrades: entity.trunkMaxUpgrades,
      created: entity.created,
      updated: entity.updated,
    );
  }
}
