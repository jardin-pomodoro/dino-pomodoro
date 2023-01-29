
import 'package:flutter/cupertino.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';

class PendingInvitations extends StatelessWidget {
  const PendingInvitations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Pending Invitations',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: PomodoroTheme.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}