
import 'package:flutter/cupertino.dart';
import 'action_banner.dart';
import '../../../theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PendingInvitations extends StatelessWidget {
  const PendingInvitations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ActionBanner(
                body: "Jean@pomme.fr",
                clickOnAction: _deletePendingInvitations,
                startIcon: const FaIcon(
                  FontAwesomeIcons.user,
                  color: PomodoroTheme.white,
                ),
                actionIcon: const FaIcon(
                  FontAwesomeIcons.circlePlus,
                  color: PomodoroTheme.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: ActionBanner(
                body: "Jean@pomme.fr",
                clickOnAction: _deletePendingInvitations,
                startIcon: const FaIcon(
                  FontAwesomeIcons.user,
                  color: PomodoroTheme.white,
                ),
                actionIcon: const FaIcon(
                  FontAwesomeIcons.circlePlus,
                  color: PomodoroTheme.white,
                ),
              ),
            ),
          ]
      ),
    );
  }

  void _deletePendingInvitations(String email) {
    print(email);
  }
}