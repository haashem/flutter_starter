import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:sky_store_starter/composition_root/dependencies_container.dart';
import 'package:sky_store_starter/router/app_router.dart';

class SkyStoreApp extends StatelessWidget {
  final DependenciesContainer conatiner;
  const SkyStoreApp({
    required this.conatiner,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      builder: (context, child) => AuthScope(
        store: conatiner.store,
        child: child!,
      ),
    );
  }
}
