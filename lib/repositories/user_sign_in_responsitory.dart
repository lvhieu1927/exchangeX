import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String exchangeLink =
    "https://exchangex123.000webhostapp.com/api_change_data/exchange_event/user_sign_up.php";

Future<String> submitSignUpTransaction(
    String username,
    String password,
    String identityCard,
    String fullName,
    String email,
    String phoneNumber) async {
  String result = "fail";
  print("67 ${username} 7 ${password} 77 ${identityCard} 77 ${fullName} 77 ${email} 777 ${phoneNumber} ");
  try {
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;
    map['identity_card'] = identityCard;
    map['fullname'] = fullName;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    final response = await http.post(Uri.parse(exchangeLink), body: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      result = response.body.toString();
    }
  } on Exception catch (e) {
    debugPrint(
        'exchangedebug: getHistoryExchange print error: ' + e.toString());
  }
  return result;
}
