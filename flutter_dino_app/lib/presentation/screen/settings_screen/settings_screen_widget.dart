import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:go_router/go_router.dart';

class SettingsScreenWidget extends StatelessWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.settings);
  }

  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings'),
    );
  }
}