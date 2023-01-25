import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/forest_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/friends_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/growing_screen/growing_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/seeds_screen/seeds_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/settings_screen/settings_screen_widget.dart';
import 'package:flutter_dino_app/presentation/screen/shop_screen/shop_screen_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // wrap width
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
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                "https://www.meme-arsenal.com/memes/d29acd0532739c9f8ee906853db0e103.jpg"),
          ),
          const SizedBox(height: 16),
          Text(
            'Pain man',
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
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
            leading: const FaIcon(FontAwesomeIcons.stopwatch),
            title: const Text('Pomodoro'),
            onTap: () => GrowingScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.tree),
            title: const Text('Forêt'),
            onTap: () => ForestScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.seedling),
            title: const Text('Graines'),
            onTap: () => SeedsScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.userGroup),
            title: const Text('Amis'),
            onTap: () => FriendsScreenWidget.navigateTo(context),
          ),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.shop),
            title: const Text('Boutique'),
            onTap: () => ShopScreenWidget.navigateTo(context),
          ),
          Divider(color: Theme.of(context).dividerColor),
          ListTile(
            leading: const FaIcon(FontAwesomeIcons.gear),
            title: const Text('Paramètres'),
            onTap: () => SettingsScreenWidget.navigateTo(context),
          ),
        ],
      ),
    );
  }
}
