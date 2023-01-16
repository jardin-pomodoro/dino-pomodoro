import 'package:flutter_dino_app/data/datasource/api/api.dart';
import 'package:pocketbase/pocketbase.dart';

import 'api_consumer.dart';

class ApiPocketBase implements Api {
  static const String baseUrl = 'https://pocketbase.nospy.fr/';

  @override
  ApiConsumer connect() {
    return ApiConsumer(PocketBase(baseUrl));
  }
}
