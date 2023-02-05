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

  factory SeedType.fromJson(Map<String, dynamic> json) {
    return SeedType(
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      timeToGrow: json['time_to_grow'] as int,
      price: json['price'] as int,
      reward: json['reward'] as int,
      leafMaxUpgrades: json['leaf_max_upgrades'] as int,
      trunkMaxUpgrades: json['trunk_max_upgrades'] as int,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'id': id,
      'name': name,
      'image': image,
      'time_to_grow': timeToGrow,
      'price': price,
      'reward': reward,
      'leaf_max_upgrades': leafMaxUpgrades,
      'trunk_max_upgrades': trunkMaxUpgrades,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }
}
