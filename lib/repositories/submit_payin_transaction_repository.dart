import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String exchangeLink =
    "https://exchangex123.000webhostapp.com/api_change_data/exchange_event/get_payin_post_key.php";

Future<String> submitPayInTransaction(
    String? username,
    String password,
    double amountVND,
    String description) async {
  String result = "fail";
  try {
    var map = new Map<String, dynamic>();
    map['username'] = username.toString();
    map['password'] = password.toString();
    map['amountVND'] = amountVND.toString();
    map['description'] = description.toString();
    final response = await http.post(Uri.parse(exchangeLink), body: map);
    debugPrint("exchangeXDebug: response payin: "+response.body.toString());
    if (response.statusCode == 200) {
      //dynamic jsonRaw = json.decode(response.body);
      result = response.body;
    }
  } on Exception catch (e) {
    debugPrint(
        'exchangedebug: getHistoryExchange print error: ' + e.toString());
  }
  return result;
}
