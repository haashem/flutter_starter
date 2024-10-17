import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
part 'auth_state.dart';

sealed class AuthEvent {
  const AuthEvent();
  factory AuthEvent.signin() = _SigninEvent;
  factory AuthEvent.signout() = _SignoutEvent;
}

class _SigninEvent extends AuthEvent {
  _SigninEvent();
}

class _SignoutEvent extends AuthEvent {
  _SignoutEvent();
}

mixin SetStateMixin<S> on Emittable<S> {
  void setState(S state) => emit(state);
}

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with SetStateMixin<AuthState> {
  final TokenStorage<Token> storage;
  StreamSubscription<Token?>? _subscription;

  AuthBloc(super.initialState, {required this.storage}) {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        final _SigninEvent e => _signIn(e, emit),
        final _SignoutEvent e => _signOut(e, emit),
      },
    );

    _subscription = storage.getStream().listen(
      (token) {
        if (token == null) {
          setState(
            AuthState.initial(status: AuthenticationStatus.unauthenticated),
          );
        } else {
          setState(
            AuthState.initial(status: AuthenticationStatus.authenticated),
          );
        }
      },
    );
  }

  Future<void> _signIn(
    _SigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.initial(status: AuthenticationStatus.authenticated));
  }

  Future<void> _signOut(
    _SignoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthState.failure(status: state.status, error: 'failed to sign out'));
    emit(AuthState.initial(status: AuthenticationStatus.unauthenticated));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
