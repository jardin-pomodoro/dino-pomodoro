import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/models/seed_type.dart';
import 'presentation/router.dart';
import 'presentation/state/seed_type/seed_type_state_notifier.dart';
import 'presentation/state/seed_type/seed_type_provider.dart';
import 'presentation/theme/theme.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return _displayRoutedPages();
    }
    final AsyncValue<List<SeedType>> providers =
        ref.watch(fetchSeedTypesProvider);
    return providers.when(
      data: _onDataArrive,
      error: _onError,
      loading: _onLoading,
    );
  }

  Widget _onLoading() {
    return const MaterialApp(
      home: Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return MaterialApp(home: Scaffold(body: Text('error ref $error')));
  }

  Widget _onDataArrive(List<SeedType> seedTypes) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dataLoaded = true;
        ref
            .read(seedTypeStateNotifierProvider.notifier)
            .addSeedTypes(seedTypes);
      });
    });
    return _displayRoutedPages();
  }

  Widget _displayRoutedPages() {
    return MaterialApp.router(
      title: appTitle,
      routerConfig: router,
    );
  }
}
