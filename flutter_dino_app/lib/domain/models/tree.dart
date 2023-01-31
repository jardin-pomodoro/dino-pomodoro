import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';

@immutable
class Tree {
  final DateTime created;
  final DateTime ended;
  final DateTime started;
  final DateTime updated;
  final int reward;
  final int timeToGrow;
  final SeedTypeExpand expand;
  final String collectionId;
  final String collectionName;
  final String id;
  final String seedType;
  final String user;

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

  get seedTypeExpand => expand.seedType;
}
