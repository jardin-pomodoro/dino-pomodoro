import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/state/pomodoro_states/seed_type_state_notifier.dart';
import 'package:flutter_dino_app/presentation/state/seed_type/seed_type_provider.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_theme/json_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeStr = await rootBundle.loadString('assets/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(ProviderScope(child: MyApp(theme: theme)));
}

class MyApp extends ConsumerStatefulWidget {
  final ThemeData theme;

  const MyApp({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool dataLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return MaterialApp.router(
        title: appTitle,
        theme: widget.theme,
        routerConfig: router,
      );
    }
    final AsyncValue<List<SeedTypeProvider>> providers =
        ref.watch(fetchSeedTypesProvider);
    return providers.when(
      data: ((seedTypes) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            dataLoaded = true;
            ref.read(seedTypeStateNotifierProvider.notifier).addSeedTypes(
                seedTypes
                    .map((e) => SeedType(
                        collectionId: e.collectionId,
                        collectionName: e.collectionName,
                        id: e.id,
                        name: e.name,
                        image: e.image,
                        timeToGrow: e.timeToGrow,
                        price: e.price,
                        reward: e.reward,
                        leafMaxUpgrades: e.leafMaxUpgrades,
                        trunkMaxUpgrades: e.trunkMaxUpgrades,
                        created: e.created,
                        updated: e.updated))
                    .toList());
          });
        });
        return MaterialApp.router(
          title: appTitle,
          theme: widget.theme,
          routerConfig: router,
        );
      }),
      error: (error, stackTrace) =>
          MaterialApp(home: Scaffold(body: Text('error ref $error'))),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
