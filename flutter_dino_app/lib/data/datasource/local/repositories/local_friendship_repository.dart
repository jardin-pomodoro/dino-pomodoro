import '../../api/entity/friendship_entity.dart';

import '../../../../core/success.dart';
import '../../../../domain/models/friendship.dart';
import '../../../../domain/repositories/friendship_repository.dart';

class LocalFriendshipRepository implements FriendshipRepository {
  @override
  Future<Success<Friendship>> acceptFriendship(Friendship friendship) async {
    // TODO: implement retrieveFriendships
    return Success.fromFailure(failureMessage: "Not implemented yet");
  }

  @override
  Future<Success<void>> rejectFriendship(Friendship friendship) async {
    // TODO: implement retrieveFriendships
    return Success.fromFailure(failureMessage: "Not implemented yet");
  }

  @override
  Future<Success<void>> removeFriendship(String userId) async {
    // TODO: implement retrieveFriendships
    return Success.fromFailure(failureMessage: "Not implemented yet");
  }

  @override
  Future<Success<List<Friendship>>> retrieveFriendships(String userId) async {
    // TODO: implement retrieveFriendships
    return Success.fromFailure(failureMessage: "Not implemented yet");
  }

  @override
  Future<Success<Friendship>> sendFriendshipRequest(
      CreateFriendship createFriendship) async {
    // TODO: implement retrieveFriendships
    return Success.fromFailure(failureMessage: "Not implemented yet");
  }
}
