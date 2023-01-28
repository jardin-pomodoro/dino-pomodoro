import 'package:flutter/material.dart';

@immutable
class SeedType {
  final String collectionId;
  final String collectionName;
  final String id;
  final String name;
  final String image;
  final int timeToGrow;
  final int price;
  final int reward;
  final int leafMaxUpgrades;
  final int trunkMaxUpgrades;
  final DateTime created;
  final DateTime updated;

  const SeedType({
    required this.collectionId,
    required this.collectionName,
    required this.id,
    required this.name,
    required this.image,
    required this.timeToGrow,
    required this.price,
    required this.reward,
    required this.leafMaxUpgrades,
    required this.trunkMaxUpgrades,
    required this.created,
    required this.updated,
  });
}
