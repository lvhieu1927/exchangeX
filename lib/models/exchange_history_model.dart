
class ExchangeHistory {
  final String currencyExchange;
  final String date;
  final num vndBalanceChangedValue;
  final num currencyBalanceChangedValue;
  final num ExchangeRateValue;
  final num isSell;

  // ignore: non_constant_identifier_names
  ExchangeHistory({required this.currencyExchange, required this.date, required this.vndBalanceChangedValue, required this.currencyBalanceChangedValue,
    required this.ExchangeRateValue,required this.isSell});

  factory ExchangeHistory.fromJson(Map<String, dynamic> json) {
    return ExchangeHistory(
      currencyExchange: json['currencyExchange'].toString() ,
      date: json['date'].toString(),
      vndBalanceChangedValue: num.parse(json['vndBalanceChangedValue']),
      currencyBalanceChangedValue: num.parse(json['currencyBalanceChangedValue']),
      ExchangeRateValue: num.parse(json['ExchangeRateValue']),
      isSell: num.parse(json['isSell']),
    );
  }
}
