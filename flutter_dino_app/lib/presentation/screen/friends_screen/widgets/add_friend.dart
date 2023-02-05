import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../state/friendship/friendship_provider.dart';
import '../../../../state/friendship/friendship_state_notifier.dart';
import '../../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../theme/theme.dart';
import '../../../widgets/snackbar.dart';
import 'action_banner.dart';
import 'add_friend_form.dart';

class AddFriend extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final Function(String) addFriend;

  const AddFriend({
    super.key,
    required this.controller,
    required this.addFriend,
  });

  @override
  ConsumerState<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends ConsumerState<AddFriend> {
  @override
  Widget build(BuildContext context) {
    final providers = ref.watch(friendshipServiceProvider);
    final friendships = ref.watch(sentPendingFriendshipsStateNotifierProvider);
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
          child: Column(
            children: [
              AddFriendForm(
                controller: widget.controller,
                addFriend: widget.addFriend,
              ),
              const Divider(
                color: PomodoroTheme.white,
                height: 10,
                thickness: 0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Demandes envoyées",
                  style: PomodoroTheme.title4,
                ),
              ),
              ...friendships
                  .map((friendship) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: ActionBanner(
                          body: friendship.relation,
                          clickOnAction: (_) {
                            providers
                                .removeFriendship(friendship.id)
                                .then((success) {
                              if (success.isSuccess) {
                                showSnackBar(
                                    context, "Demande d'amitié supprimé !");
                                _refreshFriendships(ref, context);
                              }
                            });
                          },
                          startIcon: const FaIcon(
                            FontAwesomeIcons.user,
                            color: PomodoroTheme.white,
                          ),
                          actionIcon: const FaIcon(
                            FontAwesomeIcons.circleMinus,
                            color: PomodoroTheme.white,
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
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
