import 'dart:convert';
import 'package:exchangex/models/user_information_model.dart';

UserInformation? decodeUserInformation(String ?responseBody)  {
  UserInformation? UserInformationList = null;
  dynamic jsonRaw = json.decode(responseBody!);
    List<dynamic> data = jsonRaw["userInformation"];
    data.forEach((element) {
      UserInformationList = UserInformation.fromJson(element);
    });
  return UserInformationList ;
}

