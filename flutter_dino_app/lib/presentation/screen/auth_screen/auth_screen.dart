import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/state/api_consumer/api_consumer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/auth/auth.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<OAuth2Provider>> providers =
        ref.watch(authMethodProvider);
    return providers.when(
      data: ((authMethod) {
        return Scaffold(
          body: Column(
            children: authMethod
                .map((e) => ElevatedButton(
                      onPressed: () {
                        final api = ref.read(apiProvider);
                        api.authWithDiscord();
                      },
                      child: Text(e.name),
                    ))
                .toList(),
          ),
        );
      }),
      error: (error, stackTrace) => Text('error ref' + error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
