import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent {
  final String username;
  final String password;

  DoLoginEvent(this.username, this.password);

  @override
  List<Object> get props => [];
}

class DoLoginWhenHasUsernameEvent extends LoginEvent {

  final String password;
  final bool isBiometric;

  DoLoginWhenHasUsernameEvent(this.password, this.isBiometric);

  @override
  List<Object> get props => [];
}

class CheckUserEvent extends LoginEvent {

  @override
  List<Object> get props => [];
}