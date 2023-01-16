import 'package:pocketbase/pocketbase.dart';

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
}
