import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../state/friendship/friendship_state_notifier.dart';
import '../friends_banner.dart';

class FriendsTab extends ConsumerWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendships = ref.watch(acceptedFriendshipsStateNotifierProvider);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: friendships.map(
            (friendship) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: FriendsBanner(
                userId: friendship.user,
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
