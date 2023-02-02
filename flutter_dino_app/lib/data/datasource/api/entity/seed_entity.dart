import 'seed_type_expand_entity.dart';

class SeedEntity {
  final String id;
  final String collectionId;
  final String collectionName;
  final String seedType;
  final String user;
  final SeedTypeExpandEntity expand;
  final int leafLevel;
  final int trunkLevel;
  final DateTime created;
  final DateTime updated;

  get seedTypeExpand => expand.seedType;

  SeedEntity({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.seedType,
    required this.user,
    required this.expand,
    required this.leafLevel,
    required this.trunkLevel,
    required this.created,
    required this.updated,
  });

  factory SeedEntity.fromJson(Map<String, dynamic> json) {
    return SeedEntity(
      id: json['id'],
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      seedType: json['seed_type'],
      user: json['user'],
      expand: SeedTypeExpandEntity.fromJson(json['expand']),
      leafLevel: json['leaf_level'],
      trunkLevel: json['trunk_level'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'seed_type': seedType,
      'user': user,
      'leaf_level': leafLevel,
      'trunk_level': trunkLevel,
    };
  }
}

class CreateSeed {
  final String seedType;
  final String user;
  final int leafLevel;
  final int trunkLevel;

  CreateSeed({
    required this.seedType,
    required this.user,
    required this.leafLevel,
    required this.trunkLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'seed_type': seedType,
      'user': user,
      'leaf_level': leafLevel,
      'trunk_level': trunkLevel,
    };
  }
}
