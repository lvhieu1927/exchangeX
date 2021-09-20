import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggingInState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedInState extends LoginState {
  final String token;

  LoggedInState(this.token);

  @override
  List<Object> get props => [token];
}

class ErrorState extends LoginState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}