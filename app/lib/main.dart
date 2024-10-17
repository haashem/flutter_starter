import 'dart:async';
import 'dart:developer';

import 'package:sky_store_starter/composition_root/app_runner.dart';

void main() => runZonedGuarded(() => const AppRunner().initializeAndRun(),
        (error, stackTrace) {
      log('Zone error: $error');
    });
