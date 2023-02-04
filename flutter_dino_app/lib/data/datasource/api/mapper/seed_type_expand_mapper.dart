import 'package:flutter_dino_app/data/datasource/api/mapper/seed_type_mapper.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';

import '../entity/seed_type_expand_entity.dart';


class SeedTypeExpandMapper {
  static SeedTypeExpand fromEntity(SeedTypeExpandEntity entity) {
    return SeedTypeExpand(
      seedType: SeedTypeMapper.fromEntity(entity.seedType),
    );
  }
}