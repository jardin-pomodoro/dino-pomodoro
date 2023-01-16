import 'package:flutter_dino_app/data/datasource/api/api.dart';
import 'package:pocketbase/pocketbase.dart';

import 'api_consumer.dart';

class ApiPocketBase implements Api {
  @override
  ApiConsumer connect() {
    return ApiConsumer(PocketBase('https://pocketbase.nospy.fr/'));
  }
}
