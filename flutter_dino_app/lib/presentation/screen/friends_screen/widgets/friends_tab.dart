import 'package:flutter/cupertino.dart';

import '../friends_banner.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
        child: Column(
          children: const [
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
          ],
        ),
    ),
      );
  }
}