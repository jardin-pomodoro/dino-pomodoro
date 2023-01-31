import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screen/forest_screen/forest_screen_widget.dart';
import '../screen/friends_screen/friends_screen_widget.dart';
import '../screen/growing_screen/growing_screen_widget.dart';
import '../screen/seeds_screen/seeds_screen_widget.dart';
import '../screen/settings_screen/settings_screen_widget.dart';
import '../screen/shop_screen/shop_screen_widget.dart';
import '../state/pomodoro_states/auth_state_notifier.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: PomodoroTheme.background,
      width: 250,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final connectedUser = ref.watch(authStateNotifierProvider);

          return Column(
            children: [
              CircleAvatar(
                radius: 62,
                backgroundColor: PomodoroTheme.white,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: PomodoroTheme.primary,
                  backgroundImage: NetworkImage(connectedUser.avatar),
                ),
              ),
              const SizedBox(height: 16),
              Text(connectedUser.username, style: PomodoroTheme.title3),
            ],
          );
        },
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.stopwatch,
              color: PomodoroTheme.white,
            ),
            title: const Text(
              'Pomodoro',
              style: PomodoroTheme.text,
            ),
            onTap: () => GrowingScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.tree,
              color: PomodoroTheme.white,
            ),
            title: const Text(
              'Forêt',
              style: PomodoroTheme.text,
            ),
            onTap: () => ForestScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.seedling,
              color: PomodoroTheme.white,
            ),
            title: const Text(
              'Graines',
              style: PomodoroTheme.text,
            ),
            onTap: () => SeedsScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.userGroup,
              color: PomodoroTheme.white,
            ),
            title: const Text(
              'Amis',
              style: PomodoroTheme.text,
            ),
            onTap: () => FriendsScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.shop,
              color: PomodoroTheme.white,
            ),
            title: const Text(
              'Boutique',
              style: PomodoroTheme.text,
            ),
            onTap: () => ShopScreenWidget.navigateTo(context),
          ),
          const Divider(
            color: PomodoroTheme.white,
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.gear,
              color: PomodoroTheme.white,
            ),
            title: const Text(
              'Paramètres',
              style: PomodoroTheme.text,
            ),
            onTap: () => SettingsScreenWidget.navigateTo(context),
          ),
        ],
      ),
    );
  }
}
