import 'package:flutter_dino_app/data/datasource/api/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

enum Collection {
  users,
  seedTypes,
}

extension CollectionName on Collection {
  String get name {
    switch (this) {
      case Collection.users:
        return 'users';
      case Collection.seedTypes:
        return 'seed_type';
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

  Future<List<RecordModel>> fetchSeeds() async {
    final seedTypes = await pb.collection(Collection.seedTypes.name)
        .getFullList();
    
    print(seedTypes.toString());
    return seedTypes;
  }
}
