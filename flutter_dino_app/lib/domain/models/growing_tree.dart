import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';

@immutable
class GrowingTree {
  final String collectionId;
  final String collectionName;
  final String id;
  final String seed;
  final String user;
  final DateTime started;
  final DateTime ended;
  final int reward;
  final int timeToGrow;
  final DateTime created;
  final DateTime updated;
  final SeedTypeExpand expand;

  const GrowingTree({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.id,
    required this.seed,
    required this.expand,
    required this.updated,
    required this.user,
    required this.started,
    required this.ended,
    required this.reward,
    required this.timeToGrow,
  });
}
