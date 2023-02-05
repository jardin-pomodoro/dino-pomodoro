import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

import 'entity/friendship_entity.dart';
import 'entity/growing_entity.dart';
import 'entity/seed_entity.dart';
import 'entity/tree_entity.dart';
import 'pocketbase.dart';

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
  static const github = 'github';
}

class ApiConsumer {
  final PocketBase pb;

  ApiConsumer(this.pb);

  Future<AuthMethodsList> getAuthMethods() async {
    return pb.collection(Collection.users.name).listAuthMethods();
  }

  authWithOAuth2(String provider, String code, String codeVerifier) async {
    final authData = await pb.collection(Collection.users.name).authWithOAuth2(
          provider,
          code,
          codeVerifier,
          '${ApiPocketBase.baseUrl}redirect.html',
        );
    print(authData);
    return pb.authStore;
  }

  authWithPassword(String email, String password) async {
    return pb
        .collection(Collection.users.name)
        .authWithPassword(email, password);
  }

  Future<RecordAuth> authRefresh() async {
    return pb.collection(Collection.users.name).authRefresh();
  }

  Future<RecordAuth> updateUserInfo(
      String userId, Map<String, dynamic> body) async {
    await pb.collection(Collection.users.name).update(userId, body: body);
    return pb.collection(Collection.users.name).authRefresh();
  }

  Future updateUserBalance(String userId, int balance) async {
    await pb.collection(Collection.users.name).update(
      userId,
      body: {
        'balance': balance,
      },
    );
  }

  Future<RecordAuth> updateUserAvatar(String userId, File avatar) async {
    await pb.collection(Collection.users.name).update(
      userId,
      files: [
        http.MultipartFile.fromBytes(
          'avatar',
          avatar.readAsBytesSync(),
          filename: avatar.path.split('/').last,
        ),
      ],
    );
    return pb.collection(Collection.users.name).authRefresh();
  }

  Future<void> logout() async {
    pb.authStore.clear();
  }

  Future<List<RecordModel>> fetchSeeds() async {
    final seedTypes =
        await pb.collection(Collection.seedTypes.name).getFullList();

    // print(seedTypes.toString());
    return seedTypes;
  }

  Future<List<RecordModel>> fetchOwnedSeeds(String userId) async {
    final ownedSeeds = await pb.collection(Collection.seed.name).getFullList(
          filter: 'user = "$userId"',
          expand: 'seed_type',
        );

    // print(ownedSeeds.toString());
    return ownedSeeds;
  }

  Future<RecordModel> addNewSeed(CreateSeed createSeed) async {
    final record = await pb.collection(Collection.seed.name).create(
          body: createSeed.toJson(),
          expand: 'seed_type',
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
          expand: 'seed_type',
        );
    return record;
  }

  Future<List<RecordModel>> fetchGrowing(String userId) async {
    final growing = await pb.collection(Collection.growing.name).getFullList(
          filter: 'user = "$userId"',
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
              filter: 'user = "$userId" || relation = "$userId"',
            );

    return friendship;
  }

  Future<List<RecordModel>> fetchFriendshipRequests(String userId) async {
    final friendship =
        await pb.collection(Collection.friendship.name).getFullList(
              filter:
                  '(user == "$userId" || relation == "$userId") && status == pending',
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
          expand: 'seed_type',
        );
    return record;
  }

  Future<RecordModel> fetchUser(String userId) async {
    return pb.collection(Collection.users.name).getOne(userId);
  }

  Future<RecordModel> fetchUserByEmail(String email) async {
    final record = await pb.collection(Collection.users.name).getFirstListItem(
          'email="$email"',
        );
    return record;
  }
}
