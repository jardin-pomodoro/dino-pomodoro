class SeedTypeEntity {
  final String id;
  final String collectionId;
  final String collectionName;
  final String name;
  final String image;
  final int timeToGrow;
  final int price;
  final int reward;
  final int leafMaxUpgrades;
  final int trunkMaxUpgrades;
  final DateTime created;
  final DateTime updated;

  SeedTypeEntity({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.name,
    required this.image,
    required this.timeToGrow,
    required this.price,
    required this.reward,
    required this.leafMaxUpgrades,
    required this.trunkMaxUpgrades,
  });

  factory SeedTypeEntity.fromJson(Map<String, dynamic> map) {
    return SeedTypeEntity(
      id: map['id'],
      collectionId: map['collectionId'],
      collectionName: map['collectionName'],
      created: DateTime.parse(map['created']),
      updated: DateTime.parse(map['updated']),
      name: map['name'],
      image: map['image'],
      timeToGrow: map['time_to_grow'],
      price: map['price'],
      reward: map['reward'],
      leafMaxUpgrades: map['leaf_max_upgrades'],
      trunkMaxUpgrades: map['trunk_max_upgrades'],
    );
  }
}
