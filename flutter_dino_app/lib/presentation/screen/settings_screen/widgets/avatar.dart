import 'package:flutter/material.dart';

import '../../../../domain/models/user.dart';
import '../../../theme/theme.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.connectedUser}) : super(key: key);

  final User connectedUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 155,
            backgroundColor: PomodoroTheme.white,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: PomodoroTheme.primary,
              backgroundImage: NetworkImage(connectedUser.avatar),
            ),
          ),
        ),
        Container(
          height: 300,
          width: 320,
          alignment: Alignment.bottomRight,
          child: const CircleAvatar(
            radius: 23,
            backgroundColor: PomodoroTheme.white,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: PomodoroTheme.primary,
              child: Icon(
                size: 25,
                Icons.edit,
                color: PomodoroTheme.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
