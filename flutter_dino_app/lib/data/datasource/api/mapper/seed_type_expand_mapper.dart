import '../../../../domain/models/seed_type_expand.dart';
import '../entity/seed_type_expand_entity.dart';
import 'seed_type_mapper.dart';

class SeedTypeExpandMapper {
  static SeedTypeExpand fromEntity(SeedTypeExpandEntity entity) {
    return SeedTypeExpand(
      seedType: SeedTypeMapper.fromEntity(entity.seedType),
    );
  }
}
