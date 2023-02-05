import '../../../../core/success.dart';
import '../../../../domain/models/friendship.dart';

import '../../../../domain/repositories/friendship_repository.dart';
import '../api_consumer.dart';
import '../entity/friendship_entity.dart';
import '../mapper/friendship_mapper.dart';

class ApiFriendshipRepository implements FriendshipRepository {
  final ApiConsumer apiConsumer;

  ApiFriendshipRepository(this.apiConsumer);

  @override
  Future<Success<Friendship>> acceptFriendship(Friendship friendship) async {
    try {
      await apiConsumer
          .updateFriendship(FriendshipMapper.fromModel(friendship));
      return Success(data: null);
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }

  @override
  Future<Success<void>> rejectFriendship(Friendship friendship) async {
    try {
      await apiConsumer
          .updateFriendship(FriendshipMapper.fromModel(friendship));
      return Success(data: null);
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }

  @override
  Future<Success<void>> removeFriendship(String friendshipId) async {
    try {
      await apiConsumer.deleteFriendship(friendshipId);
      return Success(data: null);
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }

  @override
  Future<Success<List<Friendship>>> retrieveFriendships(String email) async {
    try {
      final friendships = (await apiConsumer.fetchFriendship(email))
          .map((e) => FriendshipEntity.fromJson(e.toJson()))
          .map(FriendshipMapper.fromEntity)
          .toList();
      return Success(data: friendships);
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }

  @override
  Future<Success<Friendship>> sendFriendshipRequest(
      CreateFriendship createFriendship) async {
    try {
      final friendship = (await apiConsumer.addFriendship(createFriendship));
      return Success(
          data: FriendshipMapper.fromEntity(
              FriendshipEntity.fromJson(friendship.toJson())));
    } catch (e) {
      return Success.fromFailure(failureMessage: e.toString());
    }
  }
}
