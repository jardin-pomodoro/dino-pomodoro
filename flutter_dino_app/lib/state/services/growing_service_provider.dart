import 'package:flutter_dino_app/data/datasource/api/repositories/api_growing_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/services/grow_service.dart';
import '../api_consumer/api_consumer.dart';

final growingServiceProvider = Provider<GrowService>((ref) {
  final apiConsumer = ref.read(apiProvider);
  return GrowService(ApiGrowingRepository(apiConsumer));
});
