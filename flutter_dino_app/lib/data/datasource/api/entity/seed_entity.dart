import 'package:flutter_dino_app/data/datasource/api/entity/seed_type_expand_Entity.dart';

class SeedTypeEntity {
  final String id;
  final String collectionId;
  final String collectionName;
  final String seedType;
  final SeedTypeExpandEntity expand;
  final int leafLevel;
  final int trunkLevel;
  final DateTime created;
  final DateTime updated;

  get seedTypeExpand => expand.seedType;

  SeedTypeEntity({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.seedType,
    required this.expand,
    required this.leafLevel,
    required this.trunkLevel,
    required this.created,
    required this.updated,
  });

  factory SeedTypeEntity.fromJson(Map<String, dynamic> json) {
    return SeedTypeEntity(
      id: json['id'],
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      seedType: json['seed_type'],
      expand: SeedTypeExpandEntity.fromJson(json['expand']),
      leafLevel: json['leaf_level'],
      trunkLevel: json['trunk_level'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}
