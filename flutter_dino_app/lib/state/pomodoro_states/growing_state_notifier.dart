import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/growing.dart';

@immutable
class GrowingState {
  final bool isGrowing;
  final bool isFailed;
  final bool isEnded;
  final DateTime? started;
  final DateTime? ended;
  final Growing? growing;

  const GrowingState({
    required this.isGrowing,
    required this.isFailed,
    required this.isEnded,
    required this.started,
    required this.ended,
    required this.growing,
  });

  GrowingState copyWith({
    bool? isGrowing,
    bool? isFailed,
    bool? isEnded,
    DateTime? started,
    DateTime? ended,
    Growing? growing,
  }) {
    return GrowingState(
      isGrowing: isGrowing ?? this.isGrowing,
      isFailed: isFailed ?? this.isFailed,
      isEnded: isEnded ?? this.isEnded,
      started: started ?? this.started,
      ended: ended ?? this.ended,
      growing: growing ?? this.growing,
    );
  }
}

class GrowingStateNotifier extends StateNotifier<GrowingState> {
  GrowingStateNotifier()
      : super(const GrowingState(
          isGrowing: false,
          isFailed: false,
          isEnded: false,
          started: null,
          ended: null,
          growing: null,
        ));

  void startGrowing(Growing growing) {
    state = state.copyWith(
      isGrowing: true,
      isFailed: false,
      started: DateTime.now(),
      ended: null,
      growing: growing,
    );
  }

  void endGrowing() {
    state = state.copyWith(
      isGrowing: false,
      isFailed: false,
      isEnded: true,
      ended: DateTime.now(),
    );
  }

  void failGrowing() {
    state = state.copyWith(
      isGrowing: false,
      isFailed: true,
      isEnded: false,
      ended: DateTime.now(),
    );
  }

  void reset() {
    state = const GrowingState(
      isGrowing: false,
      isFailed: false,
      isEnded: false,
      started: null,
      ended: null,
      growing: null,
    );
  }
}

final growingStateNotifierProvider =
    StateNotifierProvider<GrowingStateNotifier, GrowingState>((ref) {
  return GrowingStateNotifier();
});

final isGrowingProvider = Provider<bool>((ref) {
  return ref.watch(growingStateNotifierProvider).isGrowing;
});
