class Balance{
  final String currency;
  final num balanceValue;

  Balance(this.currency, this.balanceValue);
}

class ExchangeHistory {
  final String currencyExchange;
  final String date;
  final num vndBalanceChangedValue;
  final num currencyBalanceChangedValue;
  final num ExchangeRateValue;
  final bool isSell;

  ExchangeHistory(this.currencyExchange, this.date, this.vndBalanceChangedValue, this.currencyBalanceChangedValue, this.ExchangeRateValue,this.isSell);
}

class PayInHistory{
  final String date;
  final num value;
  final String description;

  PayInHistory(this.date, this.value, this.description);
}

class User{
  final String userName;
  final String identifyCard;
  final String fullName;
  final String email;
  final String phoneNumber;
  final List<Balance> balanceList;
  final List<ExchangeHistory> exchangeHistoryList;
  final List<PayInHistory> payInHistoryList;

  User(this.userName, this.identifyCard, this.fullName, this.email, this.phoneNumber, this.balanceList, this.exchangeHistoryList, this.payInHistoryList);
}