import '../../core/success.dart';
import '../../data/datasource/api/entity/friendship_entity.dart';
import '../models/friendship.dart';

abstract class FriendshipRepository {
  Future<Success<List<Friendship>>> retrieveFriendships(String userId);
  Future<Success<Friendship>> sendFriendshipRequest(CreateFriendship createFriendship);
  Future<Success<void>> removeFriendship(String userId);
  Future<Success<void>> rejectFriendship(Friendship friendship);
  Future<Success<Friendship>> acceptFriendship(Friendship friendship);
}
