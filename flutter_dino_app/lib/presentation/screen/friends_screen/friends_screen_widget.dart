import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/friends_banner.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/widgets/slider_choice.dart';
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
        children: const [
         SliderChoice(items: [
           "Amis",
           "Demandes",
           "Invitations",
         ]),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(
              body: "Rémy",
              treeGrown: "52",
              timeWhereTreeGrown: "120",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(
              body: "Rémy",
              treeGrown: "52",
              timeWhereTreeGrown: "120",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(
              body: "Rémy",
              treeGrown: "52",
              timeWhereTreeGrown: "120",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: FriendsBanner(
              body: "Rémy",
              treeGrown: "52",
              timeWhereTreeGrown: "120",
            ),
          ),
        ]
      ),
    );
  }
}
