part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}
