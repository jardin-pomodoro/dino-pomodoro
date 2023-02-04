import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/growing_screen/growing_screen_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/auth/auth.dart';
import '../../../state/auth/auth_service_provider.dart';
import '../../../state/pomodoro_states/auth_state_notifier.dart';
import 'widgets/manual_authentification_modal.dart';
import 'widgets/oauth_login_modal.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<OAuth2Provider>> providers =
        ref.watch(authMethodProvider);

    final authService = ref.read(authServiceProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getUserAuth().then((value) {
        if (value.isSuccess){
          ref.read(authStateNotifierProvider.notifier).setUser(value.data!);
          GrowingScreenWidget.navigateTo(context);
        }
      });
    });

    return providers.when(
      data: ((authMethods) {
        List<Widget> loginSolutions = authMethods
            .map((provider) => buildOauthLoginModal(provider, context))
            .toList();
        loginSolutions.add(const ManualAuthentification());
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: loginSolutions,
            ),
          ],
        );
      }),
      error: (error, stackTrace) => Text('error ref $error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
