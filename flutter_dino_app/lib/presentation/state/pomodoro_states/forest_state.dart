import 'dart:math';

import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/domain/models/seed_type_expand.dart';
import 'package:flutter_dino_app/domain/models/tree.dart';

const userId1 = '60f9f1f0-9b1f-11eb-8dcd-0242ac130';
const userId2 = '60f9f1f0-9b1f-11eb-8dcd-0242ac130004';

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
    timeToGrow: 65,
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

