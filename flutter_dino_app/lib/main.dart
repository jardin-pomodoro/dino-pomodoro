import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/auth_screen/auth_screen.dart';
import 'package:flutter_dino_app/presentation/screen/pomodoro_screen/pomodoro_screen.dart';
import 'data/datasource/api/api_consumer.dart';
import 'data/datasource/api/pocketbase.dart';
import 'presentation/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AuthScreen(),
    );
  }
}
