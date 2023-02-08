import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/success.dart';
import '../../data/datasource/api/entity/friendship_entity.dart';
import '../../domain/models/friendship.dart';
import '../../domain/models/user.dart';
import '../../domain/services/friendship_service.dart';
import '../../domain/services/user_service.dart';
import '../pomodoro_states/auth_state_notifier.dart';
import '../user/user_provider.dart';
import 'friendship_provider.dart';

class FriendshipStateNotifier extends StateNotifier<List<Friendship>> {
  FriendshipStateNotifier() : super([]);

  void addFriendship(Friendship friendship) {
    state = [...state, friendship];
  }

  void removeFriendship(Friendship friendship) {
    state = state.where((element) => element != friendship).toList();
  }

  void clearFriendships() {
    state = [];
  }

  void addFriendships(List<Friendship> friendships) {
    state = [...state, ...friendships];
  }
}

final friendshipStateNotifierProvider =
    StateNotifierProvider<FriendshipStateNotifier, List<Friendship>>((ref) {
  return FriendshipStateNotifier();
});

final receivedPendingFriendshipsStateNotifierProvider =
    Provider<List<Friendship>>((ref) {
  final friendships = ref.watch(friendshipStateNotifierProvider);
  final userAuth = ref.watch(authStateNotifierProvider);

  return friendships
      .where(
        (friendship) =>
            friendship.relation == userAuth.user.id &&
            friendship.status == FriendshipStatus.pending,
      )
      .toList();
});

final sentPendingFriendshipsStateNotifierProvider =
    Provider<List<Friendship>>((ref) {
  final friendships = ref.watch(friendshipStateNotifierProvider);
  final userAuth = ref.watch(authStateNotifierProvider);

  return friendships
      .where((friendship) =>
          friendship.user == userAuth.user.id &&
          friendship.status == FriendshipStatus.pending)
      .toList();
});

final acceptedFriendshipsStateNotifierProvider =
    Provider<List<Friendship>>((ref) {
  final friendships = ref.watch(friendshipStateNotifierProvider);

  return friendships
      .where((friendship) => friendship.status == FriendshipStatus.accepted)
      .toList();
});

final userFriendProvider = FutureProvider<List<Success<User>>>((ref) {
  final UserService service = ref.read(userServiceProvider);
  final userAuth = ref.watch(authStateNotifierProvider);
  final friends = ref.watch(acceptedFriendshipsStateNotifierProvider);

  return Future.wait(
    friends.map((friendship) async {
      final friend = userAuth.user.id == friendship.relation
          ? friendship.user
          : friendship.relation;
      return service.fetchUserById(friend);
    }).toList(),
  );
});

final addFriendshipProvider =
    FutureProvider.family<Success<void>, String>((ref, email) async {
  final UserService service = ref.read(userServiceProvider);
  final userAuth = ref.watch(authStateNotifierProvider);

  final FriendshipService friendshipService =
      ref.watch(friendshipServiceProvider);
  final user = await service.fetchUserByEmail(email);
  return friendshipService.sendFriendshipRequest(CreateFriendship(
      user: userAuth.user.id,
      relation: user.data!.id,
      status: FriendshipStatus.pending));
});
