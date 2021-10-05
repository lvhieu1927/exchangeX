import 'dart:convert';
import 'package:exchangex/models/exchange_history_model.dart';
import 'package:exchangex/models/payin_history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String exchangeHistoryLink ="https://exchangex123.000webhostapp.com/api_get_data/get_exchange_history.php";

Future<String> getHistoryExchange(String ?username)  async {
  String result = "";
  try {
    final response = await http.post(
        Uri.parse(exchangeHistoryLink),
        body: {
          'username': username,
        }
    );
    if (response.statusCode == 200) {
      result = response.body;
    }
  } on Exception catch (e) {
    debugPrint('exchangedebug: getHistoryExchange print error: '+e.toString());
  }
  return result ;
}

List<ExchangeHistory> decodeHistoryExchange(String?responseBody) {
  List<ExchangeHistory> exchangeHistoryList = <ExchangeHistory>[];
  dynamic jsonRaw = json.decode(responseBody!);
  List<dynamic> data = jsonRaw["exchange_history"];
  data.forEach((element) {
    exchangeHistoryList.add(ExchangeHistory.fromJson(element));
  });
  return exchangeHistoryList ;
}


final String payInHistoryLink ="https://exchangex123.000webhostapp.com/api_get_data/get_payin_history.php";

Future<String> getPayInHistory(String ?username)  async {
  String result = "";
  try {
    final response = await http.post(
        Uri.parse(payInHistoryLink),
        body: {
          'username': username,
        }
    );
    if (response.statusCode == 200) {
      result = response.body;
    }
  } on Exception catch (e) {
    debugPrint('exchangedebug: gePayInHistory print error: '+e.toString());
  }
  return result;
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
