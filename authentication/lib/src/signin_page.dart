import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthScope.of(context, listen: false).signIn();
          },
          child: const Text('Sign in'),
        ),
      ),
    );
  }
}
