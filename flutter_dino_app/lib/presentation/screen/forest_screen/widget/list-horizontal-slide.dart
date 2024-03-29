import 'package:flutter/cupertino.dart';

import '../../../theme/theme.dart';

class TreeStatsUi {
  final String image;
  final int number;

  TreeStatsUi({
    required this.image,
    required this.number,
  });
}

class ListHorizontalSlide extends StatefulWidget {
  final List<TreeStatsUi> treesStatsUi;

  const ListHorizontalSlide({
    super.key,
    required this.treesStatsUi,
  });

  @override
  State<ListHorizontalSlide> createState() => _ListHorizontalSlideState();
}

class _ListHorizontalSlideState extends State<ListHorizontalSlide> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.treesStatsUi.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: PomodoroTheme.accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      widget.treesStatsUi[index].image,
                      width: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.treesStatsUi[index].number.toString(),
                      style: PomodoroTheme.title4,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
