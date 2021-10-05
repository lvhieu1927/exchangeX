import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String exchangeLink =
    "https://exchangex123.000webhostapp.com/api_change_data/exchange_event/insert_exchange.php";

Future<String> submitTransaction(
    String? username,
    String currency,
    double currencyAmount,
    double vndAmount,
    num exchangeRate,
    bool isSell) async {
  String result = "fail";
  print("67${username}7${currency} 77 ${currencyAmount} 77 ${vndAmount} 77 ${exchangeRate} 777 ${isSell} ");
  try {
    var map = new Map<String, dynamic>();
    map['username'] = username.toString();
    map['currency'] = currency.toString();
    map['currencyamount'] = currencyAmount.toString();
    map['vndamount'] = vndAmount.toString();
    map['exchangerate'] = exchangeRate.toString();
    map['issell'] = isSell ? "1" : "0";
    final response = await http.post(Uri.parse(exchangeLink), body: map);
    print(response.toString());
    print("87${username}7${currency} 77 ${currencyAmount} 77 ${vndAmount} 77 ${exchangeRate} 777 ${isSell} ");
    if (response.statusCode == 200) {
      dynamic jsonRaw = json.decode(response.body);
      result = jsonRaw["transaction"];
    }
  } on Exception catch (e) {
    debugPrint(
        'exchangedebug: getHistoryExchange print error: ' + e.toString());
  }
  return result;
}
