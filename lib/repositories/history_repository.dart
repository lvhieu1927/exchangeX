import 'dart:convert';
import 'package:exchangex/models/exchange_history_model.dart';
import 'package:exchangex/models/payin_history_model.dart';

List<ExchangeHistory> decodeHistoryExchange(String?responseBody) {
  List<ExchangeHistory> exchangeHistoryList = <ExchangeHistory>[];
  dynamic jsonRaw = json.decode(responseBody!);
  List<dynamic> data = jsonRaw["exchange_history"];
  data.forEach((element) {
    exchangeHistoryList.add(ExchangeHistory.fromJson(element));
  });
  return exchangeHistoryList ;
}



List<PayInHistory> decodePayInHistory(String ?responseBody) {
  List<PayInHistory> payInHistoryList = <PayInHistory>[];
  dynamic jsonRaw = json.decode(responseBody!);
  List<dynamic> data = jsonRaw["payInHistory"];
  data.forEach((element) {
    payInHistoryList.add(PayInHistory.fromJson(element));
  });
  return payInHistoryList ;
}
