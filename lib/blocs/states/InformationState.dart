import 'package:equatable/equatable.dart';
import 'package:exchangex/models/user_model.dart';

abstract class InformationState extends Equatable{
  const InformationState();

  @override
  List<Object> get props => [];
}

class InformationStateInitial extends InformationState{}

class InformationStateSuccessFetched extends InformationState{
  double totalBalance;
  User user;

  InformationStateSuccessFetched({required this.user,required this.totalBalance});

  List<Object> get props => [user];
}