import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/auth_state_notifier.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/text_form_field_dialog.dart';

class SettingsScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.settings);
  }

  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectedUser = ref.watch(authStateNotifierProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 155,
                    backgroundColor: PomodoroTheme.white,
                    child: CircleAvatar(
                      radius: 150,
                      backgroundColor: PomodoroTheme.primary,
                      backgroundImage: NetworkImage(connectedUser.avatar),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  width: 320,
                  alignment: Alignment.bottomRight,
                  child: const CircleAvatar(
                    radius: 23,
                    backgroundColor: PomodoroTheme.white,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: PomodoroTheme.primary,
                      child: Icon(
                        size: 25,
                        Icons.edit,
                        color: PomodoroTheme.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Pseudo:",
                  style: PomodoroTheme.title3,
                ),
                const SizedBox(width: 10),
                Text(
                  connectedUser.username,
                  style: PomodoroTheme.title3,
                ),
                const Spacer(),
                // Icon button
                IconButton(
                  onPressed: () => _handleUpdateUsername(
                      context, connectedUser.username, ref),
                  icon: const Icon(
                    Icons.edit,
                    color: PomodoroTheme.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email:",
                  style: PomodoroTheme.title3,
                ),
                const SizedBox(width: 10),
                Text(
                  connectedUser.email,
                  style: PomodoroTheme.title3,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () =>
                      _handleUpdateEmail(context, connectedUser.email, ref),
                  icon: const Icon(
                    Icons.edit,
                    color: PomodoroTheme.white,
                  ),
                )
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PomodoroTheme.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: PomodoroTheme.white,
                      width: 2,
                    )),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Déconnexion",
                  style: PomodoroTheme.title2,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _handleUpdateUsername(BuildContext context, String username, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) =>
          TextFormFieldDialog(initialValue: username, label: "Pseudo"),
    ).then((value) {
      if (value != null && value is String) {
        ref.read(authStateNotifierProvider.notifier).setUsername(value);
        showSnackBar(context, "Pseudo mis à jour",
            duration: const Duration(seconds: 1));
      }
    });
  }

  _handleUpdateEmail(BuildContext context, String email, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => TextFormFieldDialog(
          initialValue: email, label: "Email", isEmail: true),
    ).then((value) {
      if (value != null && value is String) {
        ref.read(authStateNotifierProvider.notifier).setEmail(value);
        showSnackBar(context, "Email mis à jour",
            duration: const Duration(seconds: 1));
      }
    });
  }
}
