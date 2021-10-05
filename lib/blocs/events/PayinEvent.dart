import 'package:equatable/equatable.dart';

abstract class PayInEvent extends Equatable {}

class PayInEventSubmitting extends PayInEvent {
  final String password;
  final double amountVND;
  final String description;

  PayInEventSubmitting(this.password, this.amountVND, this.description);
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
