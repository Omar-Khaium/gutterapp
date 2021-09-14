part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}

class LoginNetworking extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;
  final int expiresIn;

  LoginSuccess({required this.token, required this.expiresIn});
}
