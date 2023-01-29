import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'action_banner.dart';
import 'add_friend_form.dart';

class AddFriend extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) addFriend;

  const AddFriend({
    super.key,
    required this.controller,
    required this.addFriend,
  });

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 8.0),
          child: Column(
            children: [
              AddFriendForm(
                controller: widget.controller,
                addFriend: widget.addFriend,
              ),
              const Divider(
                color: PomodoroTheme.white,
                height: 10,
                thickness: 0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Demandes envoyées",
                  style: PomodoroTheme.title4,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: ActionBanner(
                  body: "Jean@pomme.fr",
                  clickOnAction: _deletePendingInvitations,
                  startIcon: const FaIcon(
                    FontAwesomeIcons.user,
                    color: PomodoroTheme.white,
                  ),
                  actionIcon: const FaIcon(
                    FontAwesomeIcons.circleMinus,
                    color: PomodoroTheme.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deletePendingInvitations(String email) {
    print(email);
  }
}
