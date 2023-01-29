
import 'package:flutter/cupertino.dart';
import 'package:flutter_dino_app/presentation/screen/forest_screen/widget/list-horizontal-slide.dart';
import 'package:flutter_dino_app/presentation/screen/friends_screen/widgets/action_banner.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PendingInvitations extends StatelessWidget {
  const PendingInvitations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: ActionBanner(
              body: "Jean@pomme.fr",
              clickOnAction: _deletePendingInvitations,
              startIcon: FaIcon(
                FontAwesomeIcons.user,
                color: PomodoroTheme.white,
              ),
              actionIcon: FaIcon(
                FontAwesomeIcons.circlePlus,
                color: PomodoroTheme.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: ActionBanner(
              body: "Jean@pomme.fr",
              clickOnAction: _deletePendingInvitations,
              startIcon: FaIcon(
                FontAwesomeIcons.user,
                color: PomodoroTheme.white,
              ),
              actionIcon: FaIcon(
                FontAwesomeIcons.circlePlus,
                color: PomodoroTheme.white,
              ),
            ),
          ),
        ]
    );
  }

  void _deletePendingInvitations(String email) {
    print(email);
  }
}