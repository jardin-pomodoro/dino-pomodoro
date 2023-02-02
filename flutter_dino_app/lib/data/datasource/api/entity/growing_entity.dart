import 'seed_type_expand_entity.dart';

class GrowingEntity {
  final String id;
  final String collectionId;
  final String collectionName;
  final String seedType;
  final String user;
  final SeedTypeExpandEntity expand;
  final int timeToGrow;
  final DateTime created;
  final DateTime updated;

  GrowingEntity({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.seedType,
    required this.user,
    required this.expand,
    required this.timeToGrow,
    required this.created,
    required this.updated,
  });

  factory GrowingEntity.fromJson(Map<String, dynamic> json) {
    return GrowingEntity(
      id: json['id'],
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      seedType: json['seed_type'],
      user: json['user'],
      expand: SeedTypeExpandEntity.fromJson(json['expand']),
      timeToGrow: json['time_to_grow'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}

class CreateGrow {
  final String seedType;
  final String user;
  final int reward;
  final int timeToGrow;

  CreateGrow({
    required this.seedType,
    required this.user,
    required this.reward,
    required this.timeToGrow,
  });

  Map<String, dynamic> toJson() {
    return {
      'seed_type': seedType,
      'user': user,
      'reward': reward,
      'time_to_grow': timeToGrow,
    };
  }
}
