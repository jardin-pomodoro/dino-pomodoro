import '../../core/success.dart';
import '../../data/datasource/api/repositories/api_friendship_repository.dart';
import '../../data/datasource/local/repositories/local_friendship_repository.dart';
import '../../domain/models/friendship.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/api/api_consumer.dart';
import '../../domain/services/friendship_service.dart';
import '../api_consumer/api_consumer.dart';
import '../pomodoro_states/auth_state_notifier.dart';

final friendshipServiceProvider = Provider<FriendshipService>((ref) {
  final ApiConsumer consumer = ref.read(apiProvider);
  final localRepository = LocalFriendshipRepository();
  final remoteRepository = ApiFriendshipRepository(consumer);

  return FriendshipService(
      localRepository: localRepository, remoteRepository: remoteRepository);
});

final fetchFriendshipsProvider =
    FutureProvider<Success<List<Friendship>>>((ref) async {
  final friendshipService = ref.watch(friendshipServiceProvider);
  final userId = ref.watch(authStateNotifierProvider).user.id;

  return friendshipService.retrieveFriendships(userId);
});
