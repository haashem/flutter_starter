import 'package:flutter/material.dart';

class InitializationFailedApp extends StatelessWidget {
  final Object error;
  final Future<void> Function()? onRetryInitialization;

  const InitializationFailedApp({
    super.key,
    required this.error,
    required this.onRetryInitialization,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Initialization failed',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: onRetryInitialization,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '$error',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
        ),
      );
}
