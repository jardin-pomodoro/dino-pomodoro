import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';

@immutable
class Tree {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String user;
  final String seedType;
  final SeedTypeExpand expand;
  final int reward;
  final int timeToGrow;
  final DateTime started;
  final DateTime ended;

  const Tree({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.user,
    required this.seedType,
    required this.expand,
    required this.reward,
    required this.timeToGrow,
    required this.started,
    required this.ended,
  });
}
