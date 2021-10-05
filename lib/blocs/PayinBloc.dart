import 'dart:convert';
import 'package:exchangex/blocs/events/PayinEvent.dart';
import 'package:exchangex/blocs/states/PayinState.dart';
import 'package:exchangex/repositories/balance_repository.dart';
import 'package:exchangex/repositories/history_repository.dart';
import 'package:exchangex/repositories/submit_payin_transaction_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayInBloc extends Bloc<PayInEvent, PayInState> {
  PayInBloc() : super(PayInStateInitial());
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Stream<PayInState> mapEventToState(PayInEvent event) async* {
    try {
      if (event is PayInEventSubmitting) {
        yield PayInStateSubmitting();

        SharedPreferences prefs = await _prefs;
        String? username = prefs.getString("username");
        String result = await submitPayInTransaction(
            username, event.password, event.amountVND, event.description);
        debugPrint("exchangeXDebug: Parameter Payin: ${username} :${":"+event.amountVND.toString()+":"+event.password+":"+event.description}");
        String message =
            "can't connect to server, please check your connection";
        bool check = false;
        if (result != null) {
          dynamic jsonRaw = json.decode(result);
          if (jsonRaw["status"] == "wrong") {
            message = "Wrong Password, can't execute transaction";
          } else if (jsonRaw["status"] == "success" &&
              jsonRaw["transaction"] == "fail") {
            message = "Something went wrong, can't do your transaction";
          } else if (jsonRaw["status"] == "success" &&
              jsonRaw["transaction"] == "success") {
            message = "Transaction successfully!";
            check = true;
          }
        }
        if (check){
          String balanceList = await getBalanceUser(username);
          debugPrint('exchangedebug: BalanceUser: ${balanceList}');
          prefs.setString("balanceList", balanceList);

          String payInHistoryList = await getPayInHistory(username);
          debugPrint('exchangedebug: payInHistoryList: ${payInHistoryList}');
          prefs.setString("payInHistoryList", payInHistoryList);

          yield PayInStateSuccessSubmit(message: message);
        }
        else
          yield PayInStateFailedSubmit(message: message);
        debugPrint("ExchangeXDebug: message Payin submit: ${message}");
      }
    } catch (e) {
      debugPrint(
          'ExchangeXDebug: PayInBloc Printing out the error: ${e.toString()}');
    }
  }
}
