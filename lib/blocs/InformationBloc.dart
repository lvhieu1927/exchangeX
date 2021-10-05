import 'package:exchangex/blocs/events/InformationEvent.dart';
import 'package:exchangex/blocs/states/InformationState.dart';
import 'package:exchangex/models/balance_model.dart';
import 'package:exchangex/models/currency_model.dart';
import 'package:exchangex/models/user_information_model.dart';
import 'package:exchangex/models/user_model.dart';
import 'package:exchangex/repositories/balance_repository.dart';
import 'package:exchangex/repositories/currency_responsitory.dart';
import 'package:exchangex/repositories/userinfomation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationBloc extends Bloc<InformationEvent,InformationState>{
  InformationBloc() : super(InformationStateInitial());
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Stream<InformationState> mapEventToState(InformationEvent event) async* {
    try{
      if (event is InformationEventFetching){
        SharedPreferences prefs = await _prefs;
        List<Balance> balanceList = decodeBalanceUser(prefs.getString("balanceList"));
        UserInformation? userInformation = decodeUserInformation(prefs.getString("userInformation"));
        User user = User.fromAPI(userInformation!, balanceList);
        List<Currency> currencies = <Currency>[];
        currencies = await getCurrencies();
        double totalBalance = balanceList[0].balanceValue;
        totalBalance = totalBalance + currencies[2].sell * balanceList[1].balanceValue;
        totalBalance = totalBalance + currencies[1].sell * balanceList[3].balanceValue;
        totalBalance = totalBalance + currencies[0].sell * balanceList[2].balanceValue;
        yield InformationStateSuccessFetched(user: user,totalBalance: totalBalance);
      }
    }catch(e)
    {
      debugPrint('exchangedebug: InformationBloc Printing out the error: ${e.toString()}');
    }
  }
}