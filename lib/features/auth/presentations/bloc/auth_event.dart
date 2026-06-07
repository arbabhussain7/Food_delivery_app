part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class CheckAuthStatusRequested extends AuthEvent {
  const CheckAuthStatusRequested();
}

class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}
