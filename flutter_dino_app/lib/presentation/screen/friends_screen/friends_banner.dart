import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/assets.dart';

import '../../theme/theme.dart';

class FriendsBanner extends StatelessWidget {
  final String body;
  final String treeGrown;
  final String timeWhereTreeGrown;

  const FriendsBanner({
    Key? key,
    required this.body,
    required this.treeGrown,
    required this.timeWhereTreeGrown,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: PomodoroTheme.secondary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      leading: const Icon(
        Icons.people_alt_outlined,
        color: PomodoroTheme.white,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            body,
            style: PomodoroTheme.title4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                    children: [
                      Text(
                        treeGrown,
                        style: PomodoroTheme.text,
                      ),
                      const Image(
                        image: AssetImage(PomodoroAssets.treeImage),
                        color: PomodoroTheme.white,
                        height: 20,
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                    children: [
                      Text(
                        "$timeWhereTreeGrown min",
                        style: PomodoroTheme.text,
                      ),
                      const Image(
                        image: AssetImage(PomodoroAssets.chronoImage),
                        color: PomodoroTheme.white,
                        height: 20,
                      ),
                    ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}