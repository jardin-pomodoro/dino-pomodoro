import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/auth/auth.dart';
import 'widgets/manual_authentification_modal.dart';
import 'widgets/oauth_login_modal.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<OAuth2Provider>> providers =
        ref.watch(authMethodProvider);
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
