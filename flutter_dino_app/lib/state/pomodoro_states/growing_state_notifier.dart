import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/growing.dart';

class GrowingStateNotifier extends StateNotifier<Growing?> {
  GrowingStateNotifier() : super(null);

  void setGrowing(Growing growing) {
    state = growing;
  }

  void endGrowing() {
    state = null;
  }
}

final growingStateNotifierProvider =
    StateNotifierProvider<GrowingStateNotifier, Growing?>((ref) {
  return GrowingStateNotifier();
});

final isGrowingProvider = Provider<bool>((ref) {
  return ref.watch(growingStateNotifierProvider) != null;
});
