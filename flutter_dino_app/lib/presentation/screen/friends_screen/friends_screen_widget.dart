import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/friends_banner.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:go_router/go_router.dart';

class FriendsScreenWidget extends StatefulWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.friends);
  }

  FriendsScreenWidget({Key? key}) : super(key: key);

  @override
  State<FriendsScreenWidget> createState() => _FriendsScreenWidgetState();
}

class _FriendsScreenWidgetState extends State<FriendsScreenWidget> {
  int? _sliding = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CupertinoSlidingSegmentedControl(
              children: const {
                0: Text("Amis"),
                1: Text("Demandes"),
                2: Text("Ajouter un ami"),
              },
              groupValue: _sliding,
              onValueChanged: (int? newValue) {
                setState(() {
                  _sliding = newValue;
                });
              },
            backgroundColor: PomodoroTheme.primary,
            thumbColor: PomodoroTheme.white,
              ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(),
          ),
        ]
      ),
    );
  }
}
