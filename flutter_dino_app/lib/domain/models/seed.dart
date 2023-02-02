import 'package:flutter/material.dart';
import 'seed_type.dart';
import 'seed_type_expand.dart';

@immutable
class Seed {
  final String collectionId;
  final String collectionName;
  final String id;
  final String seedType;
  final SeedTypeExpand expand;
  final String user;
  final int leafLevel;
  final int trunkLevel;
  final DateTime created;
  final DateTime updated;

  const Seed({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.id,
    required this.seedType,
    required this.expand,
    required this.updated,
    required this.user,
    required this.leafLevel,
    required this.trunkLevel,
  });

  Seed upgradeLeaf() {
    return Seed(
      collectionId: collectionId,
      collectionName: collectionName,
      created: created,
      id: id,
      seedType: seedType,
      expand: expand,
      updated: DateTime.now(),
      user: user,
      leafLevel: leafLevel + 1,
      trunkLevel: trunkLevel,
    );
  }

  Seed upgradeTrunk() {
    return Seed(
      collectionId: collectionId,
      collectionName: collectionName,
      created: created,
      id: id,
      seedType: seedType,
      expand: expand,
      updated: DateTime.now(),
      user: user,
      leafLevel: leafLevel,
      trunkLevel: trunkLevel + 1,
    );
  }

  SeedType get seedTypeExpand => expand.seedType;

  @override
  String toString() {
    return 'Seed{collectionId: $collectionId, collectionName: $collectionName, id: $id, seedType: $seedType, expand: $expand, user: $user, leafLevel: $leafLevel, trunkLevel: $trunkLevel, created: $created, updated: $updated}';
  }
}
