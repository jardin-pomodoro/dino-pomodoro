import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/seeds_screen/seed_card_widget.dart';
import 'package:flutter_dino_app/presentation/seeds_screen/seed_details_screen_widget.dart';
import 'package:go_router/go_router.dart';

final seeds = [
  Seed(
    collectionId: '1',
    collectionName: 'Collection 1',
    created: DateTime.now(),
    id: '1',
    seedType: '1',
    expand: SeedTypeExpand(
      seedType: SeedType(
        collectionId: '1',
        collectionName: 'Collection 1',
        id: '1',
        name: 'Saul',
        image:
            'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/klfch9yk075cmpq/canvas_removebg_preview_zRg2OoMJsv.png',
        timeToGrow: 10,
        price: 100,
        reward: 10,
        leafMaxUpgrades: 3,
        trunkMaxUpgrades: 3,
        created: DateTime.now(),
        updated: DateTime.now(),
      ),
    ),
    updated: DateTime.now(),
    user: '1',
    leafLevel: 0,
    trunkLevel: 2,
  ),
  Seed(
    collectionId: '1',
    collectionName: 'Collection 1',
    created: DateTime.now(),
    id: '2',
    seedType: '2',
    expand: SeedTypeExpand(
      seedType: SeedType(
        collectionId: '1',
        collectionName: 'Collection 1',
        id: '2',
        name: 'Cerisier',
        image:
            'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/q93aghxz9h1pl7u/canvas3_removebg_preview_AsHORCGEJN.png',
        timeToGrow: 60,
        price: 200,
        reward: 20,
        leafMaxUpgrades: 5,
        trunkMaxUpgrades: 5,
        created: DateTime.now(),
        updated: DateTime.now(),
      ),
    ),
    updated: DateTime.now(),
    user: '1',
    leafLevel: 5,
    trunkLevel: 2,
  )
];

class SeedsScreenWidget extends StatelessWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.seeds);
  }

  const SeedsScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: seeds
              .map(
                (seed) => Listener(
              onPointerUp: (_) {
                SeedDetailsScreenWidget.navigateTo(context, seed);
              },
              child: SizedBox(
                width: 180,
                child: SeedCardWidget(seed: seed),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
