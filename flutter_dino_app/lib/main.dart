import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routerConfig: router,
    );
  }
}
