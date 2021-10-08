import 'package:exchangex/blocs/SignUpBloc.dart';
import 'package:exchangex/blocs/events/SignUpEvent.dart';
import 'package:exchangex/blocs/states/SignUpState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  late TextEditingController _identifyCardController;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  Color mainColor = Color(0xff031244);
  late SignUpBloc _SignUpBloc;

  @override
  void initState() {
    super.initState();

    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _identifyCardController = TextEditingController();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _SignUpBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameController.dispose();
    _identifyCardController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocListener<SignUpBloc, SignUpState>(
            bloc: _SignUpBloc,
            listener: (context, state) {
              if (state is SignUpStateSuccessSubmit) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialog(context, state.message),
                );
                _usernameController.clear();
                _passwordController.clear();
                _emailController.clear();
                _identifyCardController.clear();
                _phoneController.clear();
                _fullNameController.clear();
              }
              if (state is SignUpStateFailedSubmit) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      _buildPopupDialog(context, state.message),
                );
              }
            },
            child:
                BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back, color: mainColor),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              Center(
                                  child: Text(
                                "Sign up your account",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: mainColor,
                                    fontWeight: FontWeight.w600),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          height: 620.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.h)),
                              color: mainColor),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                    child: Text("${_checkError(state)}",style: TextStyle(color: Colors.red, fontSize: 16.sp),),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Identity card",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _identifyCardController,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: "Ex: 123456789123",
                                            hintStyle: TextStyle(
                                                color: Colors.white24,
                                                fontSize: 14.sp),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Full name",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        keyboardType: TextInputType.name,
                                        controller: _fullNameController,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: "Ex: Nguyen Van A",
                                            hintStyle: TextStyle(
                                                color: Colors.white24,
                                                fontSize: 14.sp),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Username",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: _usernameController,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: "Ex: example_user",
                                            hintStyle: TextStyle(
                                                color: Colors.white24,
                                                fontSize: 14.sp),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Password",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller: _passwordController,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: "********",
                                            hintStyle: TextStyle(
                                                color: Colors.white24,
                                                fontSize: 14.sp),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Email",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _emailController,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: "Ex: example@gmail.com",
                                            hintStyle: TextStyle(
                                                color: Colors.white24,
                                                fontSize: 14.sp),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    alignment: Alignment.topLeft,
                                    child: Text("Phone number",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: _phoneController,
                                        cursorColor: Colors.white,
                                        decoration: InputDecoration(
                                            hintText: "Ex: 0123456789",
                                            hintStyle: TextStyle(
                                                color: Colors.white24,
                                                fontSize: 14.sp),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(double.infinity, 50.h)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.h),
                                        ))),
                                    onPressed: () {
                                      _pressedSubmitButton();
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: mainColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    state is SignUpStateSubmitting
                        ? Container(
                        height: 640.h,
                        width: 360.h,
                        child: Center(child: CircularProgressIndicator()))
                        : SizedBox(
                      height: 0,
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }

  void _pressedSubmitButton() {
    bool check = true;
    if (_identifyCardController.text == '' ||
        _fullNameController.text == '' ||
        _usernameController.text == '' ||
        _passwordController.text == '' ||
        _phoneController.text == '' ||
        _emailController.text == '') {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Error'),
                content: Text('Please check no null of the form'),
              ));
      check = false;
    }
    if (check == true)
      BlocProvider.of<SignUpBloc>(context).add(SignUpEventSubmitting(
          _passwordController.text,
          _usernameController.text,
          _identifyCardController.text,
          _fullNameController.text,
          _emailController.text,
          _phoneController.text));
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  String _checkError(SignUpState state) {
    if (state is SignUpStateError) return state.message;
    return "";
  }

  Widget _buildPopupDialog(BuildContext context, String message) {
    return new AlertDialog(
      title: const Text('Transaction Notify:'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${message}",style: TextStyle(fontSize: 20.sp,color: Colors.black),),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Close'),
        ),
      ],
    );
  }
}
