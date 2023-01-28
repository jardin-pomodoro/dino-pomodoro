import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dino_app/presentation/theme/assets.dart';

import '../../theme/theme.dart';

class FriendsBanner extends StatelessWidget {
  const FriendsBanner({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          tileColor: PomodoroTheme.secondary,
          leading: const Icon(
            Icons.people_alt_outlined,
            color: PomodoroTheme.white,
          ),
          title: Row(
            children: const [
              Text(
                "Amis",
                style: PomodoroTheme.title3,
              ),
              Image(
                image: AssetImage(PomodoroAssets.treeImage),
                color: PomodoroTheme.white,
                height: 25,
              ),
            ]
          ),
          trailing: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      "56",
                      style: PomodoroTheme.title3,
                    ),
                    Image(
                      image: AssetImage(PomodoroAssets.treeImage),
                      color: PomodoroTheme.white,
                      height: 25,
                    ),
                  ]
                ),
                Row(
                  children: const [
                    Text(
                      "56",
                      style: PomodoroTheme.title3,
                    ),
                    Image(
                      image: AssetImage(PomodoroAssets.treeImage),
                      color: PomodoroTheme.white,
                      height: 25,
                    ),
                ]
              ),
            ],
          ),
        ),
    );
  }
}