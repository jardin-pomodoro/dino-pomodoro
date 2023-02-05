import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/user.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import '../../../state/services/auth_service_provider.dart';
import '../../router.dart';
import '../../theme/theme.dart';
import '../../widgets/snackbar.dart';
import '../auth_screen/auth_screen.dart';
import 'widgets/avatar.dart';

class SettingsScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.settings);
  }

  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuth = ref.watch(authStateNotifierProvider);
    final connectedUser = userAuth.user;
    final authService = ref.read(authServiceProvider);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ..._buildAvatar(connectedUser),
            ..._buildFormField(connectedUser, context, ref),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
              onPressed: () {
                authService.logout().then(
                  (_) {
                    ref.read(authStateNotifierProvider.notifier).clearUser();
                    showSnackBar(context, 'Déconnexion réussie');
                    AuthScreen.navigateTo(context);
                  },
                );
              },
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

  List<Widget> _buildAvatar(User connectedUser) {
    return [
      const SizedBox(height: 40),
      Avatar(connectedUser: connectedUser),
      const SizedBox(height: 40),
    ];
  }

  List<Widget> _buildFormField(
      User connectedUser, BuildContext context, WidgetRef ref) {
    return [
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
    ];
  }
}
