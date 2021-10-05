import 'package:exchangex/models/payin_history_model.dart';
import 'package:exchangex/models/user_information_model.dart';

import 'balance_model.dart';
import 'exchange_history_model.dart';

class User{
  final String identifyCard;
  final String fullName;
  final String email;
  final String phoneNumber;
  final List<Balance> balanceList;

  factory User.fromAPI(UserInformation userInformation, List<Balance> balanceList){
    return User(
      identifyCard: userInformation.identifyCard,
      fullName: userInformation.fullName,
      email: userInformation.email,
      phoneNumber: userInformation.phoneNumber,
      balanceList: balanceList
    );
  }

  User({required this.identifyCard, required this.fullName, required this.email, required this.phoneNumber, required this.balanceList});
}