import 'package:equatable/equatable.dart';
import 'package:exchangex/models/currency_model.dart';
import 'package:exchangex/models/user_model.dart';

abstract class ExchangeEvent extends Equatable{
  late final List<Currency> listCurrency;
  late final Currency chosenCurrency;
  late final double fromAmount;
  late final double toAmount;
  late final bool isSell;
  late final User user;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ExchangeEvent(this.user,this.listCurrency, this.chosenCurrency, this.fromAmount,
      this.toAmount, this.isSell);
}



class FetchExchangeEvent extends ExchangeEvent {
  FetchExchangeEvent(User user, List<Currency> listCurrency, Currency chosenCurrency, double fromAmount, double toAmount, bool isSell) : super(user, listCurrency, chosenCurrency, fromAmount, toAmount, isSell);

}

class ExchangeFromAmountChange extends ExchangeEvent{
  ExchangeFromAmountChange(User user, List<Currency> listCurrency, Currency chosenCurrency, double fromAmount, double toAmount, bool isSell) : super(user, listCurrency, chosenCurrency, fromAmount, toAmount, isSell);


  @override
  List<Object> get props => [fromAmount];

}

class ExchangeEventAmountChanged extends ExchangeEvent{
  bool isFromAmount;

  ExchangeEventAmountChanged(User user, List<Currency> listCurrency, Currency chosenCurrency, double fromAmount, double toAmount, bool isSell, bool this.isFromAmount) : super(user, listCurrency, chosenCurrency, fromAmount, toAmount, isSell);


  @override
  List<Object> get props => [toAmount,fromAmount];

}

class ExchangeEventSwapCurrency extends ExchangeEvent{
  ExchangeEventSwapCurrency(User user, List<Currency> listCurrency, Currency chosenCurrency, double fromAmount, double toAmount, bool isSell) : super(user, listCurrency, chosenCurrency, fromAmount, toAmount, isSell);
    List<Object> get props => [chosenCurrency,isSell];
}

class ExchangeEventCurrencyChange extends ExchangeEvent{
  ExchangeEventCurrencyChange(User user, List<Currency> listCurrency, Currency chosenCurrency, double fromAmount, double toAmount, bool isSell) : super(user, listCurrency, chosenCurrency, fromAmount, toAmount, isSell);
    List<Object> get props => [listCurrency,chosenCurrency,isSell];
}


class ExchangeEventSubmitTransaction extends ExchangeEvent{


  ExchangeEventSubmitTransaction(User user, List<Currency> listCurrency, Currency chosenCurrency, double fromAmount, double toAmount, bool isSell) : super(user, listCurrency, chosenCurrency, fromAmount, toAmount, isSell);

  List<Object> get props => [listCurrency,chosenCurrency];
}