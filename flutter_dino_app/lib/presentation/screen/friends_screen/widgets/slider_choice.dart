import 'package:flutter/cupertino.dart';

import '../../../theme/theme.dart';

class SliderChoice<T> extends StatefulWidget {
  final List<String> items;
  final Function changeSlidingChoice;

  const SliderChoice({
    Key? key,
    required this.items,
    required this.changeSlidingChoice,
  }) : super(key: key);

  @override
  State<SliderChoice> createState() => _SliderChoiceState();
}

class _SliderChoiceState extends State<SliderChoice> {
  int _sliding = 0;
  late Map<int, Widget> _childrens;

  @override
  void initState() {
    super.initState();
    _childrens = { for (var item in widget.items) widget.items.indexOf(item) : Text(item) };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      children: _childrens,
      groupValue: _sliding,
      onValueChanged: (int? newValue) {
        setState(() {
          _sliding = newValue!;
          widget.changeSlidingChoice(widget.items[_sliding]);
        });
      },
      backgroundColor: PomodoroTheme.primary,
      thumbColor: PomodoroTheme.white,
    );
  }
}