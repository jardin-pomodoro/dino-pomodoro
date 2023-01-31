
import 'seed_type_entity.dart';

class SeedTypeExpandEntity {
  final SeedTypeEntity seedType;

  SeedTypeExpandEntity({
    required this.seedType,
  });

  factory SeedTypeExpandEntity.fromJson(Map<String, dynamic> expand) {
    final Map<String, dynamic> map = expand['seed_type'];
    return SeedTypeExpandEntity(
      seedType: SeedTypeEntity.fromJson(map),
    );
  }
}