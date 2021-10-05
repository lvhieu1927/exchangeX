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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'MyTabControl.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen() : super();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  late LoginBloc _loginBloc;
  final LocalAuthentication _localAuthentication = LocalAuthentication();


  @override
  void initState() {
    checkingForBioMetrics();
    super.initState();
    _loginBloc = BlocProvider.of(context);
    _userController = TextEditingController();
    _passwordController = TextEditingController();
    _loginBloc.add(CheckUserEvent());
  }


  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/img_login.jpg",
                height: 640.h,
                width: 360.w,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 16.h, horizontal: 16.w),
                child: BlocListener<LoginBloc, LoginState>(
                  bloc: _loginBloc,
                  listener: (context, state) {
                    if (state is ErrorState) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _showError(context, state.message);
                      });
                    }
                    if (state is LoggedInState) {
                      print('dang nhap thanh cong');
                      SchedulerBinding.instance!.addPostFrameCallback((_) {
                        Navigator.of(context).push(
                          MaterialPageRoute<ExchangeScreen>(
                            builder: (_) =>
                                BlocProvider.value(
                                  value: BlocProvider.of<ExchangeBloc>(context),
                                  child: MyTabControl(),
                                ),
                          ),
                        );
                      });
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      print("loginscreen :"+state.toString());
                      if (state is LoggingInState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      else
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 24.h),
                              SvgPicture.asset(
                                "assets/images/ic_exchangex.svg",
                                height: 86.h,
                                width: 86.w,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                'ExchangeX',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                              (state is InitialHasUserLoginState) ? hasUserLogin(
                                  state) :
                              Column(
                                children: [
                                  SizedBox(height: 65.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Tài khoản",
                                        style: TextStyle(
                                            fontSize: 14.sp, color: Colors.grey)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Tên Đăng nhập...",
                                          hintStyle:
                                          TextStyle(fontSize: 14.sp,
                                              color: Colors.grey),
                                          icon: new Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.grey,
                                            size: 24.h,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                          ),
                                          labelStyle: TextStyle(
                                              color: Colors.white)),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      controller: _userController,
                                    ),
                                  ),
                                  SizedBox(height: 28.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Mật khẩu",
                                        style: TextStyle(
                                            fontSize: 14.sp, color: Colors.grey)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Nhập mật khẩu...",
                                          hintStyle:
                                          TextStyle(fontSize: 14.sp,
                                              color: Colors.grey),
                                          icon: new Icon(
                                            Icons.lock_outline,
                                            color: Colors.grey,
                                            size: 24.h,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white),
                                          ),
                                          labelStyle: TextStyle(
                                              color: Colors.white)),
                                      obscureText: true,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      controller: _passwordController,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 47.h),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 64.w,
                                    right: 64.w),
                                child: Container(
                                  width: double.infinity,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                      gradient:
                                      RadialGradient(radius: 1.8, colors: [
                                        Color(0xFF878585),
                                        Color(0xFF00092B),
                                      ]),
                                      borderRadius:
                                      new BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0.0, 1.0),
                                          blurRadius: 0.8,
                                        ),
                                      ]),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: (){_doLogin(state);},
                                        child: Center(
                                            child: Center(
                                              child: Text(
                                                'Đăng nhập',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            )),
                                      )),
                                ),
                              ),
                              SizedBox(height: 42.h),
                              Text(
                                "Đăng ký tài khoản",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                              SizedBox(height: 7.h),
                              Divider(
                                indent: 100,
                                endIndent: 100,
                                color: Colors.white,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 7.h),
                                  child: Text("Quên mật khẩu",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.sp))),
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
      ),
    );
  }

  Widget hasUserLogin(InitialHasUserLoginState state) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Text("Xin chào", style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400)),
          SizedBox(height: 10.h,),
          Text("${state.userHasLogin.fullName}", style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400)),
          SizedBox(height: 10.h,),
          Text("${state.userHasLogin.identifyCard}", style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400)),
          SizedBox(height: 28.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            alignment: Alignment.topLeft,
            child: Text("Mật khẩu",
                style: TextStyle(
                    fontSize: 14.sp, color: Colors.grey)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                SizedBox(
                  width: 270.w,
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Nhập mật khẩu...",
                        hintStyle:
                        TextStyle(fontSize: 14.sp, color: Colors.grey),
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
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    controller: _passwordController,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                  width: 36.h,
                  child: IconButton(
                    icon: SvgPicture.asset("assets/images/ic_fingerprint.svg"),
                    color: Colors.white,
                    iconSize: 36.h,
                    tooltip: 'Login by biometric',
                    onPressed: _authenticateMe,
                  ),
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }


  void _doLogin(LoginState state) {
    if (state is InitialHasUserLoginState)
    {
      _loginBloc.add(DoLoginWhenHasUsernameEvent(_passwordController.text,false));
    }
    else
      _loginBloc.add(
        DoLoginEvent(_userController.text, _passwordController.text),
      );
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }


  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print("cancheck biomectionc: "+canCheckBiometrics.toString());
    return canCheckBiometrics;
  }

  Future<void> _authenticateMe() async {
// 8. this method opens a dialog for fingerprint authentication.
//    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authenticate for Testing", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
      // Navigator.of(context).push(
      //   MaterialPageRoute<ExchangeScreen>(
      //     builder: (_) =>
      //         BlocProvider.value(
      //           value: BlocProvider.of<ExchangeBloc>(context),
      //           child: MyTabControl(),
      //         ),
      //   ),
      // );
      _loginBloc.add(DoLoginWhenHasUsernameEvent(_passwordController.text,true));
    } catch (e) {
      print("this is error login: "+e.toString());
    }
    if (!mounted) return;
  }
}
