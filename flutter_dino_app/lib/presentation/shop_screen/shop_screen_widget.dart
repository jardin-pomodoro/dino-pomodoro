import 'package:flutter/material.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/presentation/router.dart';
import 'package:flutter_dino_app/presentation/shop_screen/seed_type_card_widget.dart';
import 'package:flutter_dino_app/presentation/shop_screen/seed_type_details_card_widget.dart';
import 'package:flutter_dino_app/presentation/theme/theme.dart';
import 'package:flutter_dino_app/presentation/widgets/price_widget.dart';
import 'package:go_router/go_router.dart';

final seedsType = [
  SeedType(
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
  SeedType(
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
  SeedType(
    collectionId: '1',
    collectionName: 'Collection 1',
    id: '3',
    name: 'Peuplier',
    image:
        'https://pocketbase.nospy.fr/api/files/lajospkke93eknf/fcli3v7obfhrwbt/canvas2_removebg_preview_MJsLsimfMy.png',
    timeToGrow: 120,
    price: 500,
    reward: 50,
    leafMaxUpgrades: 0,
    trunkMaxUpgrades: 50,
    created: DateTime.now(),
    updated: DateTime.now(),
  ),
];

class ShopScreenWidget extends StatelessWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.shop);
  }

  const ShopScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 20,
          runSpacing: 20,
          children: seedsType
              .map(
                (seedType) => Listener(
                  onPointerUp: (_) => _showBuySeedDialog(context, seedType),
                  child: SizedBox(
                    width: 180,
                    child: SeedTypeCardWidget(seedType: seedType),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  _showBuySeedDialog(BuildContext context, SeedType seedType) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        content: SeedTypeDetailsCardWidget(seedType: seedType),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(top: 20),
        actions: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: PomodoroTheme.secondary ,
                  content: Text('Graine achetée !', style: PomodoroTheme.textLarge),
                ),
              ); // TODO: Buy
              context.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PriceWidget(price: seedType.price),
            ),
          ),
        ],
      ),
    );
  }
}
