import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/auth_state_notifier.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/snackbar.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/avatar.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Avatar(connectedUser: connectedUser),
            const SizedBox(height: 40),
            TextFormField(
              initialValue: connectedUser.username,
              onChanged: (value) {
                ref.read(authStateNotifierProvider.notifier).setUsername(value);
              },
              decoration: const InputDecoration(
                labelText: "Pseudo",
                labelStyle: PomodoroTheme.textBold,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              initialValue: connectedUser.email,
              onChanged: (value) {
                ref.read(authStateNotifierProvider.notifier).setEmail(value);
              },
              decoration: const InputDecoration(
                labelText: "Email",
                labelStyle: PomodoroTheme.textBold,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PomodoroTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: PomodoroTheme.green,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {
                // todo : update user on remote
                showSnackBar(context, 'Utilisateur modifié');
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Modifier l'utilisateur",
                  style: PomodoroTheme.text,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PomodoroTheme.redLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: PomodoroTheme.secondary,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Déconnexion",
                  style: PomodoroTheme.title2.copyWith(
                    color: PomodoroTheme.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
