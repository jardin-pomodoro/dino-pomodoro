import 'entity/friendship_entity.dart';
import 'entity/growing_entity.dart';
import 'entity/seed_entity.dart';
import 'pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

import 'entity/tree_entity.dart';

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

  Future<RecordModel> addNewSeed(CreateSeed createSeed) async {
    final record = await pb.collection(Collection.seed.name).create(
          body: createSeed.toJson(),
        );
    return record;
  }

  Future<RecordModel> updateSeed(SeedEntity seedEntity) async {
    final record = await pb.collection(Collection.seed.name).update(
          seedEntity.id,
          body: seedEntity.toUpdateJson(),
        );
    return record;
  }

  Future<RecordModel> addGrowing(CreateGrow createGrow) async {
    final record = await pb.collection(Collection.growing.name).create(
          body: createGrow.toJson(),
        );
    return record;
  }

  Future<List<RecordModel>> fetchGrowing(String userId) async {
    final growing = await pb.collection(Collection.growing.name).getFullList(
          filter: 'user == "$userId"',
          expand: 'seed_type',
        );

    return growing;
  }

  Future<void> deleteGrowing(String growingId) async {
    return await pb.collection(Collection.growing.name).delete(growingId);
  }

  Future<List<RecordModel>> fetchFriendship(String userId) async {
    final friendship =
        await pb.collection(Collection.friendship.name).getFullList(
              filter: 'user == "$userId" || relation == "$userId"',
            );

    return friendship;
  }

  Future<RecordModel> addFriendship(CreateFriendship createFriendship) async {
    final record = await pb.collection(Collection.friendship.name).create(
          body: createFriendship.toJson(),
        );
    return record;
  }

  Future<RecordModel> updateFriendship(
      FriendshipEntity friendshipEntity) async {
    final record = await pb.collection(Collection.friendship.name).update(
          friendshipEntity.id,
          body: friendshipEntity.toUpdateJson(),
        );
    return record;
  }

  Future<void> deleteFriendship(String friendshipId) async {
    return await pb.collection(Collection.friendship.name).delete(friendshipId);
  }

  Future<List<RecordModel>> fetchTree(String userId) async {
    final tree = await pb.collection(Collection.tree.name).getFullList(
          filter: 'user == "$userId"',
          expand: 'seed_type',
        );

    return tree;
  }

  Future<RecordModel> addTree(CreateTree createTree) async {
    final record = await pb.collection(Collection.tree.name).create(
          body: createTree.toJson(),
        );
    return record;
  }
}
