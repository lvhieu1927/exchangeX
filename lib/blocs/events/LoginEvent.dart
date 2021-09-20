import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  DoLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}