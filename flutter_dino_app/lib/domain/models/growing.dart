import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';

@immutable
class Growing {
  final String collectionId;
  final String collectionName;
  final String id;
  final String seedType;
  final String user;
  final int reward;
  final int timeToGrow;
  final DateTime created;
  final DateTime updated;
  final SeedTypeExpand expand;

  const Growing({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.id,
    required this.seedType,
    required this.expand,
    required this.updated,
    required this.user,
    required this.reward,
    required this.timeToGrow,
  });
}
