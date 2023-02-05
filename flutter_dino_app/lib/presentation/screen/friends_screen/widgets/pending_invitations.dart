import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/widgets/snackbar.dart';
import 'package:flutter_dino_app/state/friendship/friendship_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../state/friendship/friendship_state_notifier.dart';
import '../../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../theme/theme.dart';
import 'action_banner.dart';

class PendingInvitations extends ConsumerWidget {
  const PendingInvitations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _refreshFriendships(ref, context);

    return Consumer(builder: (context, ref, child) {
      final providers = ref.watch(friendshipServiceProvider);
      final friendships =
      ref.watch(receivedPendingFriendshipsStateNotifierProvider);
      return Expanded(
        child: ListView(
            children: friendships
                .map((friendship) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: friendship.user,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  clickOnAction: (_) {
                    providers
                        .acceptFriendship(friendship)
                        .then((success) {
                      if (success.isSuccess) {
                        showSnackBar(context, "Amitié accepté !");
                        _refreshFriendships(ref, context);
                      }
                    });
                  },
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circlePlus,
                    color: PomodoroTheme.white,
                  ),
                  clickOnActionSecond: (_) {
                    providers
                        .rejectFriendship(friendship)
                        .then((success) {
                      if (success.isSuccess) {
                        showSnackBar(context, "Amitié rejeté !");
                        _refreshFriendships(ref, context);
                      }
                    });
                  },
                  actionSecondIcon: const FaIcon(
                    FontAwesomeIcons.solidCircleXmark,
                    color: PomodoroTheme.white,
                  ),
                ),
              );
            })
                .toList()),
      );
    });
  }

  void _refreshFriendships(WidgetRef ref, BuildContext context) {
    final providers = ref.watch(friendshipServiceProvider);
    final userAuth = ref.watch(authStateNotifierProvider);
    providers.retrieveFriendships(userAuth.user.id).then((friendships) {
      if (!friendships.isSuccess) {
        showSnackBar(
            context, 'Une erreur à eu lieu lors du chargement des amis');
        return;
      }
      ref.read(friendshipStateNotifierProvider.notifier).clearFriendships();
      ref
          .read(friendshipStateNotifierProvider.notifier)
          .addFriendships(friendships.data!);
    });
  }
}
