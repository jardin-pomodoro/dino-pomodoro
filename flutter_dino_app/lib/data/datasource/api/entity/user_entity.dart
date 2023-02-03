class UserEntity {
  final String collectionId;
  final String collectionName;
  final String id;
  final String username;
  final String email;
  final String avatar;
  final DateTime created;
  final DateTime updated;

  const UserEntity({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.id,
    required this.username,
    required this.email,
    required this.avatar,
    required this.updated,
  });

  UserEntity copyWith({
    String? username,
    String? avatar,
    String? email,
  }) {
    return UserEntity(
      collectionId: collectionId,
      collectionName: collectionName,
      created: created,
      id: id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      updated: updated,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> map) {
    return UserEntity(
      collectionId: map['collectionId'],
      collectionName: map['collectionName'],
      created: DateTime.parse(map['created']),
      id: map['id'],
      username: map['username'],
      email: map['email'],
      avatar: map['avatar'],
      updated: DateTime.parse(map['updated']),
    );
  }
}