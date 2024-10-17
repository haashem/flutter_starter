part of 'auth_bloc.dart';

sealed class AuthState {
  final AuthenticationStatus status;
  const AuthState({required this.status});

  factory AuthState.initial({required AuthenticationStatus status}) =
      AuthInitial;

  factory AuthState.failure({
    required AuthenticationStatus status,
    required Object error,
  }) = AuthStateFailure;
}

final class AuthInitial extends AuthState {
  const AuthInitial({required super.status});
}

final class AuthStateFailure extends AuthState {
  final Object error;

  const AuthStateFailure({
    required this.error,
    required super.status,
  });
}
