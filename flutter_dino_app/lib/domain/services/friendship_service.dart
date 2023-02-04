import '../../core/network.dart';
import '../../core/success.dart';
import '../../data/datasource/api/entity/friendship_entity.dart';
import '../models/friendship.dart';
import '../repositories/friendship_repository.dart';

class FriendshipService {
  FriendshipService({
    required this.localRepository,
    required this.remoteRepository,
  });

  final FriendshipRepository localRepository;
  final FriendshipRepository remoteRepository;

  Future<Success<List<Friendship>>> retrieveFriendships(String userId) async {
    if (await NetworkChecker.hasConnection()) {
      final friendships = await remoteRepository.retrieveFriendships(userId);
      if (friendships.isSuccess) {
        return friendships;
      }
      print(friendships.failureMessage);
    }
    return (await localRepository.retrieveFriendships(userId));
  }

  Future<Success<Friendship>> sendFriendshipRequest(
      CreateFriendship createFriendship) async {
    if (await NetworkChecker.hasConnection()) {
      final seeds =
          await remoteRepository.sendFriendshipRequest(createFriendship);
      if (seeds.isSuccess) {
        return seeds;
      }
    }
    return Success.fromFailure(failureMessage: "Network connectivity required");
  }

  Future<Success<void>> removeFriendship(String userId) async {
    if (await NetworkChecker.hasConnection()) {
      final seeds =
          await remoteRepository.removeFriendship(userId);
      if (seeds.isSuccess) {
        return seeds;
      }
    }
    return Success.fromFailure(failureMessage: "Network connectivity required");
  }

  Future<Success<void>> rejectFriendship(Friendship friendship) async {
    if (await NetworkChecker.hasConnection()) {
      final seeds =
          await remoteRepository.rejectFriendship(friendship.updateStatus(FriendshipStatus.rejected));
      if (seeds.isSuccess) {
        return seeds;
      }
    }
    return Success.fromFailure(failureMessage: "Network connectivity required");
  }

  Future<Success<Friendship>> acceptFriendship(Friendship friendship) async {
    if (await NetworkChecker.hasConnection()) {
      final seeds = await remoteRepository.acceptFriendship(friendship.updateStatus(FriendshipStatus.accepted));
      if (seeds.isSuccess) {
        return seeds;
      }
    }
    return Success.fromFailure(failureMessage: "Network connectivity required");
  }
}
