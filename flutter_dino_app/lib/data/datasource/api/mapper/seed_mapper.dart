import 'package:flutter_dino_app/data/datasource/api/mapper/seed_type_mapper.dart';

import '../../../../domain/models/seed.dart';
import '../entity/seed_entity.dart';

class SeedMapper {
  static Seed fromEntity(SeedEntity entity) {
    return Seed(
      collectionId: entity.collectionId,
      collectionName: entity.collectionName,
      id: entity.id,
      seedType: entity.seedType,
      user: entity.user,
      expand: SeedTypeMapper.fromEntityExpand(entity.expand),
      leafLevel: entity.leafLevel,
      trunkLevel: entity.trunkLevel,
      created: entity.created,
      updated: entity.updated,
    );
  }
}
