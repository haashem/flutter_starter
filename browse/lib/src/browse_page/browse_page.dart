import 'package:flutter/material.dart';

class BrowsePage extends StatelessWidget {
  final VoidCallback onLogout;
  const BrowsePage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogout,
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      ),
      body: const Center(
        child: Text('Browse Example'),
      ),
    );
  }
}
