import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable{
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpStateInitial extends SignUpState{}

class SignUpStateError extends SignUpState{
  final String message;

  SignUpStateError({required this.message});
}

class SignUpStateSubmitting extends SignUpState{}

class SignUpStateFailedSubmit extends SignUpState{
  final String message;

  @override
  List<Object> get props => [message];

  SignUpStateFailedSubmit({required this.message});
}

class SignUpStateSuccessSubmit extends SignUpState{
  final String message;

  @override
  List<Object> get props => [message];

  SignUpStateSuccessSubmit({required this.message});

}