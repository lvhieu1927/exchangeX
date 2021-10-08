import 'dart:convert';
import 'package:exchangex/models/balance_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<String> getAllData(String ?username)  async {
  String result ="";
  final String getBalanceLink
  ="https://exchangex123.000webhostapp.com/api_get_data/api_get_all_data.php?username=${username}";
  try {
    final response = await http.get(
        Uri.parse(getBalanceLink),
    );
    if (response.statusCode == 200) {
      result = response.body;
    }
  } on Exception catch (e) {
    debugPrint('exchangedebug: getBalanceJson print error: '+e.toString());
  }
  return result ;
}