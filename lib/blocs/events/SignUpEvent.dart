import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {}

class SignUpEventSubmitting extends SignUpEvent {
  final String password;
  final String username;
  final String identifyCard;
  final String fullName;
  final String email;
  final String phoneNumber;

  SignUpEventSubmitting(this.password, this.username, this.identifyCard, this.fullName, this.email, this.phoneNumber);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
