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

  static SeedEntity toEntity(Seed seed) {
    return SeedEntity(
      collectionId: seed.collectionId,
      collectionName: seed.collectionName,
      id: seed.id,
      seedType: seed.seedType,
      user: seed.user,
      expand: SeedTypeMapper.toEntityExpand(seed.expand),
      leafLevel: seed.leafLevel,
      trunkLevel: seed.trunkLevel,
      created: seed.created,
      updated: seed.updated,
    );
  }
}
