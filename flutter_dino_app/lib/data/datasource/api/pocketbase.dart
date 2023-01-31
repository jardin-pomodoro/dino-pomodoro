import 'package:flutter_dino_app/data/datasource/api/api.dart';
import 'package:pocketbase/pocketbase.dart';

import 'api_consumer.dart';

class ApiPocketBase implements Api {
  static const String baseUrl = 'https://pocketbase.nospy.fr';

  static String collectionFileUrl(String collectionId, String recordId, String fileName) {
    return '$baseUrl/api/files/$collectionId/$recordId/$fileName';
  }

  @override
  ApiConsumer connect() {
    return ApiConsumer(PocketBase(baseUrl));
  }
}
