import '../../core/success.dart';
import '../../data/datasource/api/entity/friendship_entity.dart';
import '../models/friendship.dart';

abstract class FriendshipRepository {
  Future<Success<List<Friendship>>> retrieveFriendships(String email);

  Future<Success<Friendship>> sendFriendshipRequest(
      CreateFriendship createFriendship);

  Future<Success<void>> removeFriendship(String friendshipId);

  Future<Success<void>> rejectFriendship(Friendship friendship);

  Future<Success<Friendship>> acceptFriendship(Friendship friendship);
}
