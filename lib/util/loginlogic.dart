import 'dart:convert';
import 'package:exchangex/models/status_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

final String loginLink ="https://exchangex123.000webhostapp.com/api_get_data/login.php";

class LoginClass {

  Future<String> login(String username, String password)  async {
    final response = await http.post(
      Uri.parse(loginLink),
      body: {
        'username': username,
        'password': password
      }
    );
    debugPrint('login status code: ${response.statusCode} ${response.body.toString()}');
    if (response.statusCode != 200) {
      print('failtologin');
      throw Exception('Failed to login.');
    }
    Status status = Status.fromJson(jsonDecode(response.body));
    return status.status;
  }

  @override
  Future<String>? logout() {
    // TODO: implement logout
    return null;
  }

}