import 'package:flutter/material.dart';

class PlaybackPage extends StatelessWidget {
  const PlaybackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playback'),
      ),
      body: const Center(
        child: Text('Playback Page'),
      ),
    );
  }
}
