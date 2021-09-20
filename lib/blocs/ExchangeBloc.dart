import 'package:exchangex/blocs/states/exchangeState.dart';
import 'package:exchangex/repositories/currency_responsitory.dart';
import 'package:exchangex/repositories/user_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'events/ExchangeEvent.dart';

class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {
  ExchangeBloc() : super(ExchangeStateInitial());

  @override
  Stream<ExchangeState> mapEventToState(ExchangeEvent event) async* {
    try {
      if (event is FetchExchangeEvent) {
        final currencies = await getCurrencies();
        final user = await getUser();
        yield ExchangeStateSuccessFetched(user,
            currenciesList: currencies,
            chosenCurrency: currencies[0],
            fromAmount: "",
            toAmount: "",
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
    } catch (e) {
      print('Printing out the message: $e');
      yield ExchangeStateFailedFetched();
    }
  }

  Stream<ExchangeState> _doChangeCurrencyFrom(
      ExchangeEventCurrencyChange event) async* {
    yield ExchangeStateFetching();
    yield ExchangeStateSuccessFetched(event.user,
        currenciesList: event.listCurrency,
        chosenCurrency: event.chosenCurrency,
        toAmount: event.toAmount,
        fromAmount: event.fromAmount,
        isSell: event.isSell);
  }

  Stream<ExchangeState> _doSwapCurrency(
      ExchangeEventSwapCurrency event) async* {
    yield ExchangeStateFetching();
    yield ExchangeStateSuccessFetched(event.user,
        currenciesList: event.listCurrency,
        chosenCurrency: event.chosenCurrency,
        fromAmount: event.toAmount,
        toAmount: event.fromAmount,
        isSell: !event.isSell);
  }

  Stream<ExchangeState> _doChangeAmount(
      ExchangeEventAmountChanged event) async* {
    if (((event.fromAmount == "") && event.isFromAmount) ||
        ((event.toAmount == "") && !event.isFromAmount)) {
      yield ExchangeStateSuccessFetched(event.user,
          currenciesList: event.listCurrency,
          chosenCurrency: event.chosenCurrency,
          fromAmount: "",
          toAmount: "",
          isSell: event.isSell);
    } else {
      num fromAmount = num.parse("0" + event.fromAmount);
      num toAmount = num.parse("0" + event.toAmount);
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
          currenciesList: event.listCurrency,
          chosenCurrency: event.chosenCurrency,
          fromAmount: (!event.isSell)
              ? fromAmount.toStringAsFixed(0)
              : fromAmount.toStringAsFixed(3),
          toAmount: (event.isSell)
              ? toAmount.toStringAsFixed(0)
              : toAmount.toStringAsFixed(3),
          isSell: event.isSell);
    }
  }
}
