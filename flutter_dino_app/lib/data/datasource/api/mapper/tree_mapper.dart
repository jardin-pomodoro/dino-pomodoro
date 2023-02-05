import '../../../../domain/models/tree.dart';
import '../entity/tree_entity.dart';
import 'seed_type_expand_mapper.dart';

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
