import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/forest_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/friends_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/growing_screen/growing_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/auth_screen/auth_screen.dart';
import 'package:flutter_dino_app/presentation/screen/seeds_screen/seeds_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/settings_screen/settings_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/shop_screen/shop_screen_widget.dart';
import 'package:flutter_dino_app/presentation/widgets/navigation_drawer.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteNames.login,
  routes: [
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => _scaffoldedWidget(const AuthScreen()),
    ),
    GoRoute(
      path: RouteNames.forest,
      builder: (context, state) =>
          _scaffoldedWidget(const ForestScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.friends,
      builder: (context, state) =>
          _scaffoldedWidget(const FriendsScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.growing,
      builder: (context, state) =>
          _scaffoldedWidget(const GrowingScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.seeds,
      builder: (context, state) => _scaffoldedWidget(const SeedsScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.settings,
      builder: (context, state) =>
          _scaffoldedWidget(const SettingsScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.shop,
      builder: (context, state) => _scaffoldedWidget(const ShopScreenWidget()),
    ),
  ],
  redirect: (context, state) {
    debugPrint("Going to ${state.location}");
    return null;
  },
);

Widget _scaffoldedWidget(Widget widget) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text('Garden Pomodoro'),
    ),
    drawer: const NavigationDrawerWidget(),
    body: Center(child: widget),
  );
}

abstract class RouteNames {
  static const String root = '/';
  static const String login = '/login';
  static const String forest = '/forest';
  static const String friends = '/friends';
  static const String growing = '/growing';
  static const String seeds = '/seeds';
  static const String settings = '/settings';
  static const String shop = '/shop';
}
