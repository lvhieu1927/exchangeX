import 'package:equatable/equatable.dart';

abstract class PayInState extends Equatable{
  const PayInState();

  @override
  List<Object> get props => [];
}

class PayInStateInitial extends PayInState{}

class PayInStateError extends PayInState{
  final String message;

  PayInStateError({required this.message});
}

class PayInStateSubmitting extends PayInState{}

class PayInStateFailedSubmit extends PayInState{
  final String message;

  @override
  List<Object> get props => [message];

  PayInStateFailedSubmit({required this.message});
}

class PayInStateSuccessSubmit extends PayInState{
  final String message;

  @override
  List<Object> get props => [message];

  PayInStateSuccessSubmit({required this.message});

}