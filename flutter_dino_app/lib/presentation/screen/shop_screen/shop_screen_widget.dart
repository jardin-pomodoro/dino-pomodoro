import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/seed_type.dart';
import '../../../state/seed_type/seed_type_state_notifier.dart';
import '../../router.dart';
import 'package:go_router/go_router.dart';

import 'widgets/seed_type_card_widget.dart';
import 'widgets/seed_type_details_card_widget.dart';

class ShopScreenWidget extends ConsumerWidget {
  static void navigateTo(BuildContext context) {
    context.go(RouteNames.shop);
  }

  const ShopScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notBoughtSeedsType =
        ref.watch(notBoughtSeedTypeStateNotifierProvider);
    final boughtSeedsType = ref.watch(boughtSeedTypeStateNotifierProvider);

    final seedTypeCards = <Widget>[
      ...notBoughtSeedsType
          .map(
            (seedType) => GestureDetector(
              onTap: () => _showBuySeedDialog(context, seedType, ref),
              child: SeedTypeCardWidget(seedType: seedType, bought: false),
            ),
          )
          .toList(),
      ...boughtSeedsType
          .map(
            (seedType) => SeedTypeCardWidget(seedType: seedType, bought: true),
          )
          .toList(),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: seedTypeCards,
    );
    // return SingleChildScrollView(
    //   scrollDirection: Axis.vertical,
    //   child: Center(
    //     child: Wrap(
    //       direction: Axis.horizontal,
    //       spacing: 20,
    //       runSpacing: 20,
    //       children: notBoughtSeedsType
    //           .map(
    //             (seedType) => Listener(
    //               onPointerUp: (_) =>
    //                   _showBuySeedDialog(context, seedType, ref),
    //               child: SizedBox(
    //                 width: 180,
    //                 child:
    //                     SeedTypeCardWidget(seedType: seedType, bought: false),
    //               ),
    //             ),
    //           )
    //           .toList()
    //         ..addAll(
    //           boughtSeedsType
    //               .map(
    //                 (seedType) => Listener(
    //                   child: SizedBox(
    //                     width: 180,
    //                     child: SeedTypeCardWidget(
    //                       seedType: seedType,
    //                       bought: true,
    //                     ),
    //                   ),
    //                 ),
    //               )
    //               .toList(),
    //         ),
    //     ),
    //   ),
    // );
  }

  _showBuySeedDialog(BuildContext context, SeedType seedType, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SeedTypeDetailsCardWidget(seedType: seedType),
      ),
    );
  }
}
