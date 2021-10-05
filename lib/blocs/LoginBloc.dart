import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:exchangex/blocs/states/LoginState.dart';
import 'package:exchangex/models/user_information_model.dart';
import 'package:exchangex/repositories/balance_repository.dart';
import 'package:exchangex/repositories/history_repository.dart';
import 'package:exchangex/repositories/userinfomation_repository.dart';
import 'package:flutter/cupertino.dart';
import '../util/loginlogic.dart';
import 'events/LoginEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginBloc() : super(InitialLoginState());



  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is DoLoginEvent) {
      yield* _doLogin(event);
    }
    if (event is CheckUserEvent)
      {
        yield*_checkUsernameExist(event);
      }
    if (event is DoLoginWhenHasUsernameEvent)
      {
        yield* _doLoginWhenHasUsername(event);
      }
  }

  Stream<LoginState> _doLoginWhenHasUsername(DoLoginWhenHasUsernameEvent event) async*
  {
    try {
      SharedPreferences preferences = await _prefs;
      String? username = preferences.getString('username');
      var status = "fail";
      if (!event.isBiometric){
        status = await LoginClass().login(username!, event.password);
      }
      else status = "can";
      debugPrint("exchangeX: status is: ${status}");

      if (status == "success" || status == "can"){
        String balanceList = await getBalanceUser(username);
        debugPrint('exchangeDebug: BalanceUser: ${balanceList}');
        preferences.setString("balanceList", balanceList);

        String exchangeHistoryList = await getHistoryExchange(username);
        debugPrint('exchangeDebug: exchangeHistory: ${exchangeHistoryList}');
        preferences.setString("exchangeHistoryList", exchangeHistoryList);

        String payInHistoryList = await getPayInHistory(username);
        debugPrint('exchangeDebug: payInHistoryList: ${payInHistoryList}');
        preferences.setString("payInHistoryList", payInHistoryList);

        yield LoggedInState(status);
      }
      else
        yield ErrorState("Tài khoản hoặc mật khẩu không đúng");
    } on Exception catch (e) {
      // TODO
      debugPrint("exchangeDebug: LoginBloc printing out the error: "+e.toString());
      yield ErrorState("Lỗi kết nối");
    }
  }

  Stream<LoginState> _checkUsernameExist(CheckUserEvent event) async*
  {
    SharedPreferences preferences = await _prefs;
    String username = preferences.getString('username') ?? "###";
    if (username != "###")
    {
      debugPrint("debugExchangeX: username has exit");
      String? userInformation = await getUserInformationUser(username);
      preferences.setString("userInformation", userInformation);
      UserInformation? user = decodeUserInformation(userInformation);
      yield InitialHasUserLoginState(user!);
    }
    else {
      debugPrint("debugExchangeX: username has exit");
      yield InitialLoginState();
    };
  }

  Stream<LoginState> _doLogin(DoLoginEvent event) async* {
    yield LoggingInState();
    try {
      var status = await LoginClass().login(event.username, event.password);
      print("this is status: "+status);
      if (status == "success"){
        SharedPreferences prefs = await _prefs;

        prefs.setString("username", event.username);
        final username = event.username;
        
        String? userInformation = await getUserInformationUser(username);
        debugPrint('exchangeDebug: BalanceUser: ${userInformation}');
        prefs.setString("userInformation", userInformation);

        String balanceList = await getBalanceUser(username);
        debugPrint('exchangeDebug: BalanceUser: ${balanceList}');
        prefs.setString("balanceList", balanceList);

        String exchangeHistoryList = await getHistoryExchange(username);
        debugPrint('exchangeDebug: exchangeHistory: ${exchangeHistoryList}');
        prefs.setString("exchangeHistoryList", exchangeHistoryList);

        String payInHistoryList = await getPayInHistory(username);
        debugPrint('exchangeDebug: payInHistoryList: ${payInHistoryList}');
        prefs.setString("payInHistoryList", payInHistoryList);

        yield LoggedInState(status);
      }
      else
        yield ErrorState("Tài khoản hoặc mật khẩu không đúng");
    }
    catch(e){
      debugPrint("exchangeDebug: LoginBloc printing out the error: "+e.toString());
      yield ErrorState("Lỗi kết nối");
    }
  }

}

