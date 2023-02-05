import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/user.dart';
import '../../../../state/friendship/friendship_state_notifier.dart';
import '../../forest_screen/external/friend_forest.dart';
import 'friends_banner.dart';

class FriendsTab extends ConsumerWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendships = ref.watch(userFriendProvider);

    return Expanded(
      child: SingleChildScrollView(
        child: friendships.when(
          data: (friends) {
            if (friends.isEmpty) {
              return const Center(
                child: Text('Vous n\'avez pas encore d\'amis'),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: friends.map((friend) {
                if (friend.data == null || friend.isSuccess == false) {
                  return const SizedBox.shrink();
                }
                return GestureDetector(
                  onTap: () => showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: ((context) {
                        return FriendForest(friend: friend.data!);
                      })),
                  child: FriendsBanner(user: friend.data!),
                );
              }).toList(),
            );
          },
          error: (error, stack) => Center(child: Text('Error, $error')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
