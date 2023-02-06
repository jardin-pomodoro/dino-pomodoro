import '../../../../domain/models/growing.dart';
import '../entity/growing_entity.dart';
import 'seed_type_expand_mapper.dart';

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
