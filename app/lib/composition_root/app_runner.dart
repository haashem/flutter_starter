import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sky_store_starter/composition_root/di_initializer.dart';
import 'package:sky_store_starter/widgets/initialization_failed_app.dart';
import 'package:sky_store_starter/widgets/sky_store_app.dart';

class AppRunner {
  const AppRunner();
  Future<void> initializeAndRun() async {
    try {
      final result = await DiInitializer.initialize();
      runApp(
        SkyStoreApp(
          conatiner: result,
        ),
      );
    } catch (e, _) {
      log('Failed to initialize app: $e');
      runApp(
        InitializationFailedApp(
          error: e,
          onRetryInitialization: initializeAndRun,
        ),
      );
    }
  }
}
