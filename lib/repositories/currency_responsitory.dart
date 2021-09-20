import 'dart:convert';
import 'package:exchangex/models/currency_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const String apiKey =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MzI0MjgzMjIsImlhdCI6MTYzMTEzMjMyMiwic2NvcGUiOiJleGNoYW5nZV9yYXRlIiwicGVybWlzc2lvbiI6MH0.aKmNAaSEJTHwloDQvLwA5ZcAy0U48p83DBGNgw8BNZI";
const apiExchangeRate = "/api/v2/exchange_rate/vcb";

final Uri currencyURL = Uri.https(
    'vapi.vnappmob.com', '${apiExchangeRate}', {"api_key": "${apiKey}"});

Future<List<Currency>> getCurrencies() async {
  http.Response response = await http.get(currencyURL);
  List<Currency> currencies = <Currency>[];
  if (response.statusCode == 200) {
    dynamic jsonRaw = json.decode(response.body);
    List<dynamic> data = jsonRaw["results"];
    data.forEach((c) {
      switch(Currency.fromJson(c).currency){
        case "USD":
        case "EUR":
        case "JPY":
        currencies.add(Currency.fromJson(c));
        break;
      }
    });
    currencies.forEach((element) {
      print(element.currency);
    });
  } else {
    throw Exception('Failed to connect API currency');
  }
  Currency vnd = new Currency(buy_cash: 1, buy_transfer: 1, currency: "VND", sell: 1);
  currencies.add(vnd);
  return currencies;
}
