import 'dart:convert';
import 'package:exchangex/models/balance_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String getBalanceLink ="https://exchangex123.000webhostapp.com/api_get_data/get_balance.php";

Future<String> getBalanceUser(String ?username)  async {
  String result ="";
  try {
    final response = await http.post(
        Uri.parse(getBalanceLink),
        body: {
          'username': username,
        }
    );
    if (response.statusCode == 200) {
      result = response.body;
    }
  } on Exception catch (e) {
    debugPrint('exchangedebug: getBalanceJson print error: '+e.toString());
  }
  return result ;
}

List<Balance> decodeBalanceUser(String ?responseBody){
  List<Balance> balanceList = <Balance>[];
  dynamic jsonRaw = json.decode(responseBody!);
  List<dynamic> data = jsonRaw["balance"];
  data.forEach((element) {
    balanceList.add(Balance.fromJson(element));
  });
  return balanceList;
}