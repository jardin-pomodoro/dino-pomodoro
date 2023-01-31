import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  VoidCallback? onAppResumed;
  VoidCallback? onAppInactive;
  VoidCallback? onAppPaused;
  VoidCallback? onAppDetached;

  LifecycleEventHandler({
    this.onAppResumed,
    this.onAppInactive,
    this.onAppPaused,
    this.onAppDetached,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onAppResumed?.call();
    } else if (state == AppLifecycleState.inactive) {
      onAppInactive?.call();
    } else if (state == AppLifecycleState.paused) {
      onAppPaused?.call();
    } else if (state == AppLifecycleState.detached) {
      onAppDetached?.call();
    }
  }
}
