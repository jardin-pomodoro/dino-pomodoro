import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'config/date_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DateConfig().init();
  runApp(const ProviderScope(child: MyApp()));
}
