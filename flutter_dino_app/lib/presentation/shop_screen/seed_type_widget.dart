import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:path/path.dart';

class SeedTypeWidget extends StatelessWidget {
  final SeedType seedType;

  const SeedTypeWidget({Key? key, required this.seedType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: PomodoroTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: PomodoroTheme.white,
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Image.network(seedType.image),
                Text(
                  seedType.name,
                  style: PomodoroTheme.title3,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${seedType.price}",
              style: PomodoroTheme.textLarge,
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.circle,
              color: PomodoroTheme.yellow,
            ),
          ],
        ),
      ],
    );
  }
}
