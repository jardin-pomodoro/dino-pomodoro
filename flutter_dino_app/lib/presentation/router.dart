import 'package:flutter/material.dart';
import 'screen/auth_screen/auth_screen.dart';
import 'theme/theme.dart';
import 'widgets/navigation_drawer.dart';
import 'package:go_router/go_router.dart';

import 'screen/forest_screen/forest_screen_widget.dart';
import 'screen/friends_screen/friends_screen_widget.dart';
import 'screen/growing_screen/growing_grow_screen_widget.dart';
import 'screen/growing_screen/growing_screen_widget.dart';
import 'screen/seeds_screen/seed_details_screen_widget.dart';
import 'screen/seeds_screen/seeds_screen_widget.dart';
import 'screen/settings_screen/settings_screen_widget.dart';
import 'screen/shop_screen/shop_screen_widget.dart';

final GoRouter router = GoRouter(
  initialLocation: RouteNames.login,
  routes: [
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) =>
          _scaffoldedWidgetWithoutMenu("Connexion", const AuthScreen()),
    ),
    GoRoute(
      path: RouteNames.forest,
      builder: (context, state) =>
          _scaffoldedWidget("Forêt", const ForestScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.friends,
      builder: (context, state) =>
          _scaffoldedWidget("Amis", const FriendsScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.growing,
      builder: (context, state) =>
          _scaffoldedWidget("Garden Pomodoro", const GrowingScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.growingGrow,
      builder: (context, state) => const GrowingGrowScreenWidget(),
    ),
    GoRoute(
      path: RouteNames.seeds,
      builder: (context, state) =>
          _scaffoldedWidget("Graines", const SeedsScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.seedDetails,
      builder: (context, state) => const SeedDetailsScreenWidget(),
    ),
    GoRoute(
      path: RouteNames.settings,
      builder: (context, state) =>
          _scaffoldedWidget("Paramètres", const SettingsScreenWidget()),
    ),
    GoRoute(
      path: RouteNames.shop,
      builder: (context, state) =>
          _scaffoldedWidget("Boutique", const ShopScreenWidget()),
    ),
  ],
  // Add error builder
  redirect: (context, state) {
    debugPrint("Going to ${state.location}");
    return null;
  },
);

Widget _scaffoldedWidgetWithoutMenu(String title, Widget child) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      centerTitle: true,
      title: Text(title),
      backgroundColor: PomodoroTheme.secondary,
      foregroundColor: PomodoroTheme.yellow,
    ),
    backgroundColor: PomodoroTheme.white,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    ),
  );
}

Widget _scaffoldedWidget(String title, Widget child) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(title),
      backgroundColor: PomodoroTheme.secondary,
      foregroundColor: PomodoroTheme.yellow,
    ),
    backgroundColor: PomodoroTheme.white,
    drawer: const NavigationDrawerWidget(),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
    ),
  );
}

abstract class RouteNames {
  static const String root = '/';
  static const String login = '/login';
  static const String forest = '/forest';
  static const String friends = '/friends';
  static const String growing = '/growing';
  static const String growingGrow = '/growing/grow';
  static const String seeds = '/seeds/list';
  static const String seedDetails = '/seeds/view';
  static const String settings = '/settings';
  static const String shop = '/shop';
}
