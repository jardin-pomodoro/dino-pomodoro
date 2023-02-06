import 'user_entity.dart';

class FriendshipExpandEntity {
  final UserEntity userEntity;
  final UserEntity relationEntity;

  FriendshipExpandEntity({
    required this.userEntity,
    required this.relationEntity,
  });

  factory FriendshipExpandEntity.fromJson(Map<String, dynamic> expand) {
    return FriendshipExpandEntity(
      userEntity: UserEntity.fromJson(expand['user']),
      relationEntity: UserEntity.fromJson(expand['relation']),
    );
  }
}
