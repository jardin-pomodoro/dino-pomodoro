import 'package:flutter/cupertino.dart';
import 'package:flutter_dino_app/domain/models/friendship_expand.dart';

import '../../data/datasource/api/entity/friendship_entity.dart';

@immutable
class Friendship {
  final String id;
  final String user;
  final String relation;
  final FriendshipStatus status;
  final FriendshipExpand expand;
  final DateTime updated;
  final DateTime created;
  final String collectionId;
  final String collectionName;

  const Friendship({
    required this.id,
    required this.user,
    required this.collectionId,
    required this.collectionName,
    required this.relation,
    required this.expand,
    required this.status,
    required this.updated,
    required this.created,
  });

  Friendship updateStatus(FriendshipStatus status) {
    return Friendship(
      id: id,
      user: user,
      relation: relation,
      collectionId: collectionId,
      expand: expand,
      collectionName: collectionName,
      created: created,
      updated: updated,
      status: status,
    );
  }
}
