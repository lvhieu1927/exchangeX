import 'package:equatable/equatable.dart';
import 'package:exchangex/models/user_information_model.dart';
import 'package:exchangex/repositories/userinfomation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class InitialLoginStateNewUser extends LoginState {
  @override
  List<Object> get props => [];
}

class InitialHasUserLoginState extends LoginState {
  final UserInformation userHasLogin;

  InitialHasUserLoginState(this.userHasLogin);

  @override
  List<Object> get props => [userHasLogin];
}

class LoggingInState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggedInState extends LoginState {
  final String status;

  LoggedInState(this.status);

  @override
  List<Object> get props => [status];
}

class ErrorState extends LoginState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [];
}