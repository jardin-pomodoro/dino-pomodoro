import 'package:flutter_dino_app/data/datasource/api/entity/friendship_entity.dart';

import '../../../../core/success.dart';
import '../../../../domain/models/friendship.dart';
import '../../../../domain/repositories/friendship_repository.dart';

class LocalFriendshipRepository implements FriendshipRepository {
  @override
  Future<Success<Friendship>> acceptFriendship(Friendship friendship) {
    // TODO: implement acceptFriendship
    throw UnimplementedError();
  }

  @override
  Future<Success<void>> rejectFriendship(Friendship friendship) {
    // TODO: implement rejectFriendship
    throw UnimplementedError();
  }

  @override
  Future<Success<void>> removeFriendship(String userId) {
    // TODO: implement removeFriendship
    throw UnimplementedError();
  }

  @override
  Future<Success<List<Friendship>>> retrieveFriendships(String userId) {
    // TODO: implement retrieveFriendships
    throw UnimplementedError();
  }

  @override
  Future<Success<Friendship>> sendFriendshipRequest(CreateFriendship createFriendship) {
    // TODO: implement sendFriendshipRequest
    throw UnimplementedError();
  }

}
