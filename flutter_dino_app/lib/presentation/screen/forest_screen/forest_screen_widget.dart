import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:go_router/go_router.dart';

class ForestScreenWidget extends StatelessWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.forest);
  }

  const ForestScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Forest'),
    );
  }
}
