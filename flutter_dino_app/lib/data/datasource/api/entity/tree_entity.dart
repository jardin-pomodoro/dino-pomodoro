import 'package:flutter_dino_app/data/datasource/api/entity/seed_type_expand_Entity.dart';

class TreeEntity {
  final String id;
  final String collectionId;
  final String collectionName;
  final String user;
  final String seedType;
  final SeedTypeExpandEntity expand;
  final int reward;
  final int timeToGrow;
  final DateTime started;
  final DateTime ended;
  final DateTime created;
  final DateTime updated;

  get seedTypeExpand => expand.seedType;

  TreeEntity({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.user,
    required this.seedType,
    required this.expand,
    required this.reward,
    required this.timeToGrow,
    required this.started,
    required this.ended,
    required this.created,
    required this.updated,
  });

  factory TreeEntity.fromJson(Map<String, dynamic> json) {
    return TreeEntity(
      id: json['id'],
      collectionId: json['collection_id'],
      collectionName: json['collection_name'],
      user: json['user'],
      seedType: json['seed_type'],
      expand: SeedTypeExpandEntity.fromJson(json['expand']),
      reward: json['reward'],
      timeToGrow: json['time_to_grow'],
      started: DateTime.parse(json['started']),
      ended: DateTime.parse(json['ended']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}

class CreateTree {
  final String user;
  final String seedType;
  final int reward;
  final int timeToGrow;
  final DateTime started;
  final DateTime ended;

  CreateTree({
    required this.user,
    required this.seedType,
    required this.reward,
    required this.timeToGrow,
    required this.started,
    required this.ended,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'seed_type': seedType,
      'reward': reward,
      'time_to_grow': timeToGrow,
      'started': started.toIso8601String(),
      'ended': ended.toIso8601String(),
    };
  }
}
