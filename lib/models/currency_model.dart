
import 'package:equatable/equatable.dart';

class Currency extends Equatable{
  final double buy_cash;
  final double buy_transfer;
  final String currency;
  final double sell;

  Currency(
      {required this.buy_cash,
        required this.buy_transfer,
        required this.currency,
        required this.sell});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      buy_cash: json['buy_cash'] ?? 0,
      buy_transfer: json['buy_transfer'] ?? 0,
      currency: json['currency'] ?? "Non",
      sell: json['sell'] ?? 0,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [currency];
}