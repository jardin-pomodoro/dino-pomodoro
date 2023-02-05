import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../state/friendship/friendship_provider.dart';
import '../../../state/friendship/friendship_state_notifier.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../router.dart';
import '../../widgets/snackbar.dart';
import 'widgets/add_friend.dart';
import 'widgets/friends_tab.dart';
import 'widgets/pending_invitations.dart';
import 'widgets/slider_choice.dart';

class FriendsScreenWidget extends ConsumerStatefulWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.friends);
  }

  const FriendsScreenWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FriendsScreenWidgetState();
}

class _FriendsScreenWidgetState extends ConsumerState<FriendsScreenWidget> {
  String slidingChoice = "Amis";

  @override
  Widget build(BuildContext context) {
    loadFriends(ref, context);
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: SliderChoice(
              items: const [
                "Amis",
                "Demandes",
                "Ajouter un ami",
              ],
              changeSlidingChoice: _changeSlidingChoice,
            ),
          ),
          if (slidingChoice == "Amis") const FriendsTab(),
          if (slidingChoice == "Demandes") const PendingInvitations(),
          if (slidingChoice == "Ajouter un ami")
            AddFriend(
              controller: TextEditingController(),
              addFriend: _addFriend,
            ),
        ],
      ),
    );
  }

  void _changeSlidingChoice(String choice) {
    setState(() {
      slidingChoice = choice;
    });
  }

  void _addFriend(String emailFriendAdd) {
    setState(() {
      print(emailFriendAdd);
      ref.watch(addFriendshipProvider(emailFriendAdd)).when(
            data: (_) => showSnackBar(context, "Demande d'amitié envoyé !"),
            error: (_, e) =>
                print(e.toString()),
            loading: () => null,
          );
    });
  }
}

void loadFriends(WidgetRef ref, BuildContext context) {
  final providers = ref.watch(friendshipServiceProvider);
  final userAuth = ref.watch(authStateNotifierProvider);
  providers.retrieveFriendships(userAuth.user.id).then((friendships) {
    if (!friendships.isSuccess) {
      showSnackBar(
        context,
        'Une erreur à eu lieu lors du chargement des amis',
      );
      return;
    }
    ref.read(friendshipStateNotifierProvider.notifier).clearFriendships();
    ref
        .read(friendshipStateNotifierProvider.notifier)
        .addFriendships(friendships.data!);
  });
}
