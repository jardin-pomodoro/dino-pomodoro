import 'dart:convert';

import 'package:flutter_dino_app/core/success.dart';
import 'package:flutter_dino_app/domain/models/seed.dart';
import 'package:flutter_dino_app/domain/models/seed_type.dart';
import 'package:flutter_dino_app/domain/models/user.dart';

import '../../../../domain/repositories/seed_repository.dart';
import '../database/database_source.dart';

class LocalSeedRepository implements SeedRepository {
  final DatabaseSource dbSource;

  LocalSeedRepository(this.dbSource);

  @override
  Future<Success<Seed>> buySeed(User user, SeedType seedType) {
    return Future.value(Success.fromFailure(failureMessage: 'Not implemented'));
  }

  @override
  Future<Success<void>> clear() async {
    final db = await dbSource.db();
    await db.delete('seeds');
    return Success(data: null);
  }

  @override
  Future<Success<List<Seed>>> getSeeds(String userId) async {
    final db = await dbSource.db();
    final List<Map<String, dynamic>> maps = await db.query('seeds', where: 'userId = ?', whereArgs: [userId]);
    final List<Seed> seeds =
        maps.map((e) => Seed.fromJson(jsonDecode(e['json']))).toList();
    return Success(data: seeds);
  }

  @override
  Future<Success<void>> saveSeed(User user, Seed seed, {int? price}) async {
    final db = await dbSource.db();
    await db.delete('seeds', where: 'id = ?', whereArgs: [seed.id]);
    await db.insert(
      'seeds',
      {
        'id': seed.id,
        'userId': user.id,
        'json': jsonEncode(seed),
      },
    );
    return Success(data: null);
  }

  @override
  Future<Success<void>> saveSeeds(List<Seed> seeds) async {
    final db = await dbSource.db();
    await db.delete('seeds');
    for (var seed in seeds) {
      await db.insert(
        'seeds',
        {
          'id': seed.id,
          'userId': seed.user,
          'json': jsonEncode(seed.toJson()),
        },
      );
    }
    return Success(data: null);
  }
}
