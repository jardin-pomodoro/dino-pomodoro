import 'package:flutter_dino_app/data/datasource/api/entity/friendship_entity.dart';
import 'package:flutter_dino_app/domain/models/friendship.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pomodoro_states/auth_state_notifier.dart';

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
      .where((friendship) => friendship.relation == userAuth.user.id && friendship.status == FriendshipStatus.pending)
      .toList();
});

final acceptedFriendshipsStateNotifierProvider =
    Provider<List<Friendship>>((ref) {
  final friendships = ref.watch(friendshipStateNotifierProvider);

  return friendships
      .where((friendship) => friendship.status == FriendshipStatus.accepted)
      .toList();
});
