import 'package:flutter_dino_app/data/datasource/api/entity/seed_type_expand_entity.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';

import '../../../../domain/models/seed_type.dart';
import '../entity/seed_type_entity.dart';
import '../pocketbase.dart';

class SeedTypeMapper {
  static SeedType fromEntity(SeedTypeEntity entity) {
    return SeedType(
      collectionId: entity.collectionId,
      collectionName: entity.collectionName,
      id: entity.id,
      name: entity.name,
      image: ApiPocketBase.collectionFileUrl(
          entity.collectionId, entity.id, entity.image),
      timeToGrow: entity.timeToGrow,
      price: entity.price,
      reward: entity.reward,
      leafMaxUpgrades: entity.leafMaxUpgrades,
      trunkMaxUpgrades: entity.trunkMaxUpgrades,
      created: entity.created,
      updated: entity.updated,
    );
  }

  static SeedTypeExpand fromEntityExpand(SeedTypeExpandEntity entity) {
    return SeedTypeExpand(
      seedType: fromEntity(entity.seedType),
    );
  }
}
