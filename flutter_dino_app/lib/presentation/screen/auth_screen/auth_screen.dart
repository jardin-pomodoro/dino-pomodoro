import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/auth/auth.dart';
import 'widgets/login_modal.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<OAuth2Provider>> providers =
        ref.watch(authMethodProvider);
    return providers.when(
      data: ((authMethods) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: authMethods
                  .map((provider) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext bc) => LoginModal(
                                provider: provider,
                                context: context,
                              ),
                            );
                          },
                          child: Text(provider.name),
                        ),
                      ))
                  .toList(),
            ),
          ],
        );
      }),
      error: (error, stackTrace) => Text('error ref $error'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
