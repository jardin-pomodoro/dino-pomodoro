import 'package:flutter/cupertino.dart';

import '../../../theme/theme.dart';

class ListHorizontalSlide  extends StatelessWidget {
  const ListHorizontalSlide({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
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