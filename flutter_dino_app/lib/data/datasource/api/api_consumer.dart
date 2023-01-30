import 'package:flutter_dino_app/data/datasource/api/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

enum Collection { users, seedTypes, seed, growing, friendship, tree }

extension CollectionName on Collection {
  String get name {
    switch (this) {
      case Collection.users:
        return 'users';
      case Collection.seedTypes:
        return 'seed_type';
      case Collection.seed:
        return 'seed';
      case Collection.growing:
        return 'growing';
      case Collection.friendship:
        return 'friendship';
      case Collection.tree:
        return 'tree';
    }
  }
}

abstract class AuthProvider {
  static const discord = 'discord';
  static const google = 'google';
}

class ApiConsumer {
  final PocketBase pb;

  ApiConsumer(this.pb);

  Future<AuthMethodsList> getAuthMethods() async {
    return pb.collection(Collection.users.name).listAuthMethods();
  }

  static const _uuid = Uuid();

  Future<AuthStore> authWithOAuth2() async {
    final authMethods = await getAuthMethods();
    final discord = authMethods.authProviders
        .firstWhere((element) => element.name == 'discord');
    final authData = await pb.collection(Collection.users.name).authWithOAuth2(
        'discord',
        discord.codeChallenge,
        discord.codeVerifier,
        '${ApiPocketBase.baseUrl}redirect.html',
        createData: {
          'name': 'Discord + ${_uuid.v4()}',
        });
    print(authData.toString());
    return pb.authStore;
  }

  Future<AuthStore> authWithDiscord() async {
    final authMethods = await getAuthMethods();
    final discord = authMethods.authProviders
        .firstWhere((element) => element.name == 'discord');
    final authData = await pb.collection(Collection.users.name).authWithOAuth2(
        'discord',
        discord.codeChallenge,
        discord.codeVerifier,
        '${ApiPocketBase.baseUrl}redirect.html',
        createData: {
          'name': 'Discord + ${_uuid.v4()}',
        });
    print(authData.toString());
    return pb.authStore;
  }

  Future<List<RecordModel>> fetchSeeds() async {
    final seedTypes =
        await pb.collection(Collection.seedTypes.name).getFullList();

    // print(seedTypes.toString());
    return seedTypes;
  }

  Future<List<RecordModel>> fetchOwnedSeeds(String userId) async {
    final ownedSeeds = await pb.collection(Collection.seed.name).getFullList(
          filter: 'user == "$userId"',
          expand: 'seed_type',
        );

    // print(ownedSeeds.toString());
    return ownedSeeds;
  }

  // Future<RecordModel> addNewSeed
}
