import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/datasource/api/api_consumer.dart';
import '../../../data/datasource/api/pocketbase.dart';

final apiProvider = Provider<ApiConsumer>((ref) => ApiPocketBase().connect());
