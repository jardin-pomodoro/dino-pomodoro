import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../state/friendship/friendship_provider.dart';
import '../../../../state/friendship/friendship_state_notifier.dart';
import '../../../theme/theme.dart';
import '../../../widgets/snackbar.dart';
import '../friends_screen_widget.dart';
import 'action_banner.dart';

class PendingInvitations extends ConsumerWidget {
  const PendingInvitations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loadFriends(ref, context);

    return Consumer(builder: (context, ref, child) {
      final providers = ref.watch(friendshipServiceProvider);
      final friendships =
          ref.watch(receivedPendingFriendshipsStateNotifierProvider);
      return Expanded(
        child: ListView(
            children: friendships.map((friendship) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ActionBanner(
              body: friendship.user,
              startIcon: const FaIcon(
                // TODO get le user et display le username
                FontAwesomeIcons.user,
                color: PomodoroTheme.white,
              ),
              clickOnAction: (_) {
                providers.acceptFriendship(friendship).then((success) {
                  if (success.isSuccess) {
                    showSnackBar(context, "Amitié accepté !");
                    loadFriends(ref, context);
                  }
                });
              },
              actionIcon: const FaIcon(
                FontAwesomeIcons.circlePlus,
                color: PomodoroTheme.white,
              ),
              clickOnActionSecond: (_) {
                providers.rejectFriendship(friendship).then((success) {
                  if (success.isSuccess) {
                    showSnackBar(context, "Amitié rejeté !");
                    loadFriends(ref, context);
                  }
                });
              },
              actionSecondIcon: const FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                color: PomodoroTheme.white,
              ),
            ),
          );
        }).toList()),
      );
    });
  }
}
