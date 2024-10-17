import 'package:authentication/authentication.dart';
import 'package:authentication/src/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract interface class AuthController {
  AuthenticationStatus get status;

  void signIn();
  void signOut();
}

class AuthScope extends StatefulWidget {
  final Store<Token> store;
  final Widget child;

  const AuthScope({
    super.key,
    required this.store,
    required this.child,
  });

  /// Get the [AuthController] from the [BuildContext]
  static AuthController of(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_AuthInherited>()!.controller
      : context.getInheritedWidgetOfExactType<_AuthInherited>()!.controller;

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

class _AuthScopeState extends State<AuthScope> implements AuthController {
  late final AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AuthBloc(
      storage: SecureTokenStorage(widget.store),
      AuthState.initial(status: AuthenticationStatus.unauthenticated),
    );
  }

  @override
  void signIn() {
    bloc.add(AuthEvent.signin());
  }

  @override
  void signOut() {
    bloc.add(AuthEvent.signout());
  }

  @override
  AuthenticationStatus get status => bloc.state.status;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: bloc,
      listener: (context, state) {
        switch (state) {
          case AuthStateFailure(status: _, error: final error):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$error'),
              ),
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        return _AuthInherited(
          controller: this,
          status: bloc.state,
          child: widget.child,
        );
      },
    );
  }
}

final class _AuthInherited extends InheritedWidget {
  final AuthController controller;
  final AuthState status;
  const _AuthInherited({
    required this.status,
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _AuthInherited oldWidget) =>
      status != oldWidget.status;
}
