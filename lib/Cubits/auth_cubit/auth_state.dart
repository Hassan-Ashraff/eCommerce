part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoadingAuthState extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthNotValid extends AuthState {
    final String message;

  AuthNotValid(this.message);
}
class AuthFailed extends AuthState {
  final String message;

  AuthFailed(this.message);
}




