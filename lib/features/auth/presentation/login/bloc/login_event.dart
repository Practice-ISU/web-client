part of 'login_bloc.dart';

sealed class LoginEvent {}

class SendLoginEvent extends LoginEvent {
  final String name;
  final String password;

  SendLoginEvent(this.name, this.password);
}

class RegisterEvent extends LoginEvent {
  final String name;
  final String password;

  RegisterEvent(this.name, this.password);
}