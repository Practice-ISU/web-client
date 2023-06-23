part of 'login_bloc.dart';

sealed class LoginState {}

class ProgressLoginState extends LoginState {
  final bool progress;

  ProgressLoginState(this.progress);
}

class ErrorLoginState extends LoginState {
  final String message;

  ErrorLoginState(this.message);
}