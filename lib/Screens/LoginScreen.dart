import 'package:exchangex/Screens/ExchangeScreen.dart';
import 'package:exchangex/blocs/ExchangeBloc.dart';
import 'package:exchangex/blocs/LoginBloc.dart';
import 'package:exchangex/blocs/events/LoginEvent.dart';
import 'package:exchangex/blocs/states/LoginState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Widgets/RaisedGradientButton.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.title}) : super();

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late LoginBloc _loginBloc;


  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of(context);
    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width / 360;
    var deviceHeight = queryData.size.height / 640;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/img_login.png",
              height: deviceHeight * 640,
              width: deviceWidth * 360,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    _showError(context, state.message);
                  }
                  if (state is LoggedInState) {
                    print("success!!!!!!!!!!");
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoggingInState){
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is LoggedInState){
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        Navigator.of(context).push(
                          MaterialPageRoute<ExchangeScreen>(
                            builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<ExchangeBloc>(context),
                              child: ExchangeScreen(),
                            ),
                          ),
                        );
                      });
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40 * deviceHeight),
                            child: SvgPicture.asset(
                              "assets/images/ic_exchangex.svg",
                              height: 100,
                              width: 1000,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 27 * deviceHeight),
                              child: Text(
                                'ExchangeX',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 65 * deviceHeight),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("Tài khoản",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0* deviceHeight),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Tên Đăng nhập...",
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  icon: new Icon(
                                    Icons.account_circle_outlined,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              controller: _userController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30 * deviceHeight),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text("Mật khẩu",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0 * deviceHeight),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "Nhập mật khẩu...",
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                  icon: new Icon(
                                    Icons.lock_outline,
                                    color: Colors.grey,
                                    size: 24,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white)),
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              controller: _passwordController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 48 * deviceHeight,
                                left: 64 * deviceWidth,
                                right: 64 * deviceWidth),
                            child: RaisedGradientButton(
                                child: Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                gradient2: Color(0xFF00092B),
                                gradient1: Color(0xFF878585),
                                onPressed: () {
                                  print('button clicked');
                                  _doLogin();
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 42, bottom: 16),
                            child: Text(
                              "Đăng ký tài khoản",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Divider(
                            indent: 100,
                            endIndent: 100,
                            color: Colors.white,
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Text("Quên mật khẩu",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12))),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _doLogin() {
    BlocProvider.of<LoginBloc>(context).add(
      DoLoginEvent(_userController.text, _passwordController.text),
    );
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
