part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final User user;

  AuthLoginEvent({required this.user});
}

final class AuthLogoutEvent extends AuthEvent {}
