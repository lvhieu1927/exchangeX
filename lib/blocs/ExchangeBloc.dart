import 'package:exchangex/blocs/states/exchangeState.dart';
import 'package:exchangex/models/balance_model.dart';
import 'package:exchangex/models/user_information_model.dart';
import 'package:exchangex/models/user_model.dart';
import 'package:exchangex/repositories/balance_repository.dart';
import 'package:exchangex/repositories/currency_responsitory.dart';
import 'package:exchangex/repositories/history_repository.dart';
import 'package:exchangex/repositories/submit_transaction_repository.dart';
import 'package:exchangex/repositories/userinfomation_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'events/ExchangeEvent.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeStateInitial());
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  @override
  Stream<ExchangeState> mapEventToState(ExchangeEvent event) async* {
      if (event is FetchExchangeEvent) {
        SharedPreferences prefs = await _prefs;

        final currencies = await getCurrencies();

        String? userInfor = prefs.getString("userInformation");
        UserInformation? userInformation = decodeUserInformation(userInfor);
        List<Balance> balanceList = decodeBalanceUser(
            prefs.getString("balanceList"));

        User user = User.fromAPI(userInformation!, balanceList);
        yield ExchangeStateSuccessFetched(user,"none",
            currenciesList: currencies,
            chosenCurrency: currencies[0],
            fromAmount: 0,
            toAmount: 0,
            isSell: true);
      }
      if (event is ExchangeEventCurrencyChange) {
        yield* _doChangeCurrencyFrom(event);
      }
      if (event is ExchangeEventSwapCurrency) {
        yield* _doSwapCurrency(event);
      }
      if (event is ExchangeEventAmountChanged) {
        yield* _doChangeAmount(event);
      }
      if (event is ExchangeEventSubmitTransaction) {
        yield* _submitExchangeTransaction(event);
      }

  }

  Stream<ExchangeState> _doChangeCurrencyFrom(
      ExchangeEventCurrencyChange event) async* {
    yield ExchangeStateFetching();
    yield ExchangeStateSuccessFetched(event.user,"none",
        currenciesList: event.listCurrency,
        chosenCurrency: event.chosenCurrency,
        toAmount: event.toAmount,
        fromAmount: event.fromAmount,
        isSell: event.isSell);
  }

  Stream<ExchangeState> _doSwapCurrency(
      ExchangeEventSwapCurrency event) async* {
    yield ExchangeStateFetching();
    yield ExchangeStateSuccessFetched(event.user,"none",
        currenciesList: event.listCurrency,
        chosenCurrency: event.chosenCurrency,
        fromAmount: event.toAmount,
        toAmount: event.fromAmount,
        isSell: !event.isSell);
  }

  Stream<ExchangeState> _doChangeAmount(
      ExchangeEventAmountChanged event) async* {
    if (((event.fromAmount == 0) && event.isFromAmount) ||
        ((event.toAmount == 0) && !event.isFromAmount)) {
      yield ExchangeStateSuccessFetched(event.user,"none",
          currenciesList: event.listCurrency,
          chosenCurrency: event.chosenCurrency,
          fromAmount: 0,
          toAmount: 0,
          isSell: event.isSell);
    } else {
      double fromAmount = event.fromAmount;
      double toAmount = event.toAmount;
      if (event.isSell) {
        event.isFromAmount
            ? toAmount = fromAmount * event.chosenCurrency.sell
            : fromAmount = toAmount / event.chosenCurrency.sell;
      } else {
        event.isFromAmount
            ? toAmount = fromAmount / event.chosenCurrency.buy_cash
            : fromAmount = toAmount * event.chosenCurrency.buy_cash;
      }
      yield ExchangeStateSuccessFetched(event.user,
          "none",
          currenciesList: event.listCurrency,
          chosenCurrency: event.chosenCurrency,
          fromAmount: fromAmount,
          toAmount: toAmount,
          isSell: event.isSell);
    }
  }

  Stream<ExchangeState> _submitExchangeTransaction(
      ExchangeEventSubmitTransaction event) async* {
    yield ExchangeStateSubmittingTransaction();

    SharedPreferences prefs = await _prefs;
    var username = prefs.getString("username");
    double currencyAmount = event.isSell
        ? -1 * (event.fromAmount)
        : event.toAmount;
    double vndAmount = event.isSell ? event.toAmount : (-1 *
        event.fromAmount);
    double exchangeRate = event.isSell ? event.chosenCurrency.sell : event
        .chosenCurrency.buy_cash;
    var isSell = event.isSell;

    String result = await submitTransaction(
        username, event.chosenCurrency.currency,
        currencyAmount, vndAmount, exchangeRate, isSell);

    if (result == "success"){

      String balanceList = await getBalanceUser(username);
      debugPrint('exchangedebug: BalanceUser: ${balanceList}');
      prefs.setString("balanceList", balanceList);

      String exchangeHistoryList = await getHistoryExchange(username);
      debugPrint('exchangedebug: exchangeHistory: ${exchangeHistoryList}');
      prefs.setString("exchangeHistoryList", exchangeHistoryList);

      String payInHistoryList = await getPayInHistory(username);
      debugPrint('exchangedebug: payInHistoryList: ${payInHistoryList}');
      prefs.setString("payInHistoryList", payInHistoryList);

      final currencies = await getCurrencies();

      UserInformation? userInformation = decodeUserInformation(
          prefs.getString("userInformation"));

      List<Balance> userbalanceList = decodeBalanceUser(
          prefs.getString("balanceList"));

      User user = User.fromAPI(userInformation!, userbalanceList);
      yield ExchangeStateSuccessFetched(user,
          "success",
          currenciesList: currencies,
          chosenCurrency: currencies[0],
          fromAmount: 0,
          toAmount: 0,
          isSell: true);
    }
    else
      yield ExchangeStateSuccessFetched(event.user,
          "fail",
        currenciesList: event.listCurrency,
        chosenCurrency: event.chosenCurrency,
        fromAmount: event.fromAmount,
        toAmount: event.toAmount,
        isSell: event.isSell);
  }
}


