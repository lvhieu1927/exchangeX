import 'dart:convert';
import 'package:exchangex/models/user_information_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String getUserInformationLink ="https://exchangex123.000webhostapp.com/api_get_data/get_user_information.php";

Future<String> getUserInformationUser(String ?username)  async {
  String result = "";
  try {
    final response = await http.post(
        Uri.parse(getUserInformationLink),
        body: {
          'username': username,
        }
    );
    if (response.statusCode == 200) {
      result = response.body;
    }
  } on Exception catch (e) {
    debugPrint('exchangedebug: getUserInformation print error: '+e.toString());
  }
  return result;
}

UserInformation? decodeUserInformation(String ?responseBody)  {
  UserInformation? UserInformationList = null;
  dynamic jsonRaw = json.decode(responseBody!);
  if (jsonRaw["status"] == "success") {
    List<dynamic> data = jsonRaw["userInformation"];
    data.forEach((element) {
      UserInformationList = UserInformation.fromJson(element);
    });
  }
  return UserInformationList ;
}

