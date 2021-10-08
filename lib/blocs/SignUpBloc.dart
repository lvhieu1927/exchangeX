import 'dart:convert';
import 'package:exchangex/blocs/events/SignUpEvent.dart';
import 'package:exchangex/blocs/states/SignUpState.dart';
import 'package:exchangex/repositories/user_sign_in_responsitory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpStateInitial());
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    try {
      if (event is SignUpEventSubmitting) {
        yield SignUpStateSubmitting();

        String result = await submitSignUpTransaction(
            event.username,
            event.password,
            event.identifyCard,
            event.fullName,
            event.email,
            event.phoneNumber);
        String message =
            "can't connect to server, please check your connection";
        bool check = false;
        if (result != "fail") {
          dynamic jsonRaw = json.decode(result);
          if (jsonRaw["status"] == "exist") {
            message =
                "Username or Identify Card has register before, please check again";
          } else if (jsonRaw["status"] == "success" &&
              jsonRaw["transaction"] == "fail") {
            message = "Something went wrong . . . ";
          } else if (jsonRaw["status"] == "success" &&
              jsonRaw["transaction"] == "success") {
            message = "Create account successfully!";
            check = true;
          }
          if (check) {
            yield SignUpStateSuccessSubmit(message: message);
          } else
            yield SignUpStateFailedSubmit(message: message);
        } else
          yield SignUpStateError(
              message: "Something went wrong, Please check your connection");
      }
    } catch (e) {
      debugPrint(
          'ExchangeXDebug: SignUpBloc Printing out the error: ${e.toString()}');
      yield SignUpStateError(
          message: "Something went wrong, Please check your connection");
    }
  }
}
