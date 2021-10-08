import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:exchangex/blocs/states/LoginState.dart';
import 'package:exchangex/models/user_information_model.dart';
import 'package:exchangex/repositories/balance_repository.dart';
import 'package:exchangex/repositories/get_all_data.dart';
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
    if (event is LoginEventWithOtherAcount)
      {
        yield InitialLoginStateNewUser();
      }
  }

  Stream<LoginState> _doLoginWhenHasUsername(DoLoginWhenHasUsernameEvent event) async*
  {
    try {
      yield LoggingInState();
      SharedPreferences preferences = await _prefs;
      String? username = preferences.getString('username');
      var status = "fail";
      if (!event.isBiometric){
        status = await LoginClass().login(username!, event.password);
      }
      else status = "can";
      debugPrint("exchangeX: status is: ${status}");

      if (status == "success" || status == "can"){
        String allData = await getAllData(username);
        debugPrint('exchangedebug: allData: ${allData}');
        preferences.setString("allData", allData);
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
    yield LoggingInState();
    try {
      SharedPreferences preferences = await _prefs;
      String username = preferences.getString('username') ?? "###";
      String allData = preferences.getString("allData") ?? "###";
      if (username != "###" && allData != "###")
      {
        UserInformation? user = decodeUserInformation(allData);
        yield InitialHasUserLoginState(user!);
      }
      else {
        debugPrint("debugExchangeX: username no exit");
        yield InitialLoginStateNewUser();
      };
    } on Exception catch (e) {
      // TODO
      debugPrint("Error: some error in _checkUserNameExit");
      yield ErrorState("Connection error: Please check your connection.");
    }
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
        String? allData = await getAllData(username);
        debugPrint('exchangeDebug: allData: ${allData}');
        prefs.setString("allData", allData);
        
        // String? userInformation = await getUserInformationUser(username);
        // debugPrint('exchangeDebug: UserInformation: ${userInformation}');
        // prefs.setString("userInformation", userInformation);
        //
        // String balanceList = await getBalanceUser(username);
        // debugPrint('exchangeDebug: BalanceUser: ${balanceList}');
        // prefs.setString("balanceList", balanceList);
        //
        // String exchangeHistoryList = await getHistoryExchange(username);
        // debugPrint('exchangeDebug: ExchangeHistory: ${exchangeHistoryList}');
        // prefs.setString("exchangeHistoryList", exchangeHistoryList);
        //
        // String payInHistoryList = await getPayInHistory(username);
        // debugPrint('exchangeDebug: PayInHistoryList: ${payInHistoryList}');
        // prefs.setString("payInHistoryList", payInHistoryList);

        yield LoggedInState(status);
      }
      else
        yield ErrorState("Tài khoản hoặc mật khẩu không đúng");
    }
    catch(e){
      debugPrint("exchangeDebug: LoginBloc _dologin has error: "+e.toString());
      yield ErrorState("Connection error: Please check your connection.");
    }
  }

}

