import 'package:flutter_dino_app/data/datasource/api/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uuid/uuid.dart';

enum Collection {
  users,
}

extension CollectionName on Collection {
  String get name {
    switch (this) {
      case Collection.users:
        return 'users';
    }
  }
}

class ApiConsumer {
  final PocketBase pb;

  ApiConsumer(this.pb);

  Future<AuthMethodsList> getAuthMethods() async {
    return pb.collection(Collection.users.name).listAuthMethods();
  }

  static const _uuid = Uuid();

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
}
