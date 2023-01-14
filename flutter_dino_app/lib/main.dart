import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/riverpod_training/riverpod_main_screen.dart';
import 'presentation/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final Api api = Supabse();
  // await api.connect();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          secondary: Colors.greenAccent,
        ),
      ),
      home: const RiverPodMainScreen(),
    );
  }
}
