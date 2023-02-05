class FriendshipEntity {
  final String id;
  final String collectionId;
  final String collectionName;
  final String user;
  final String relation;
  final FriendshipStatus status;
  final DateTime created;
  final DateTime updated;

  FriendshipEntity({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.user,
    required this.relation,
    required this.status,
    required this.created,
    required this.updated,
  });

  factory FriendshipEntity.fromJson(Map<String, dynamic> json) {
    return FriendshipEntity(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      user: json['user'],
      relation: json['relation'],
      status: FriendshipStatusExtension.fromString(json['status']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'user': user,
      'relation': relation,
      'status': status.value,
    };
  }
}

class CreateFriendship {
  final String user;
  final String relation;
  final FriendshipStatus status;

  CreateFriendship({
    required this.user,
    required this.relation,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'relation': relation,
      'status': status.value,
    };
  }
}

enum FriendshipStatus {
  pending,
  accepted,
  rejected,
}

extension FriendshipStatusExtension on FriendshipStatus {
  String get value {
    switch (this) {
      case FriendshipStatus.pending:
        return 'pending';
      case FriendshipStatus.accepted:
        return 'accepted';
      case FriendshipStatus.rejected:
        return 'rejected';
    }
  }

  static FriendshipStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return FriendshipStatus.pending;
      case 'accepted':
        return FriendshipStatus.accepted;
      case 'rejected':
        return FriendshipStatus.rejected;
      default:
        throw Exception('Invalid FriendshipStatus value: $value');
    }
  }
}
