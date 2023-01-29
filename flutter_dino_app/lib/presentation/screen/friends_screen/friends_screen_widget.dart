import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/friends_banner.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/widgets/friends_tab.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/widgets/pending_invitations.dart';
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
  String slidingChoice = "Amis";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
         SliderChoice(items: const [
           "Amis",
           "Demandes",
           "Ajouter un ami",
         ],
           changeSlidingChoice: _changeSlidingChoice,
         ),
          if (slidingChoice == "Amis") const FriendsTab(),
          if (slidingChoice == "Demandes") const PendingInvitations(),
          if (slidingChoice == "Ajouter un ami") const Text("Ajouter un ami"),
        ],
      ),
    );
  }

  void _changeSlidingChoice(String choice) {
    setState(() {
      slidingChoice = choice;
    });
  }
}
