import 'dart:convert';
import 'package:exchangex/models/balance_model.dart';

List<Balance> decodeBalanceUser(String ?responseBody){
  List<Balance> balanceList = <Balance>[];
  dynamic jsonRaw = json.decode(responseBody!);
  List<dynamic> data = jsonRaw["balance"];
  data.forEach((element) {
    balanceList.add(Balance.fromJson(element));
  });
  return balanceList;
}