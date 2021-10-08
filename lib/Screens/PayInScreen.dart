import 'package:exchangex/blocs/PayinBloc.dart';
import 'package:exchangex/blocs/events/PayinEvent.dart';
import 'package:exchangex/blocs/states/PayinState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PayInScreen extends StatefulWidget {
  const PayInScreen({Key? key}) : super(key: key);

  @override
  _PayInScreenState createState() => _PayInScreenState();
}

class _PayInScreenState extends State<PayInScreen> {
  late MoneyMaskedTextController _amountController;
  late TextEditingController _passwordController;
  late TextEditingController _descriptionController;
  Color mainColor = Color(0xff031244);
  late PayInBloc _payInBloc;

  @override
  void initState() {
    super.initState();
    _amountController = MoneyMaskedTextController(
        decimalSeparator: '.', thousandSeparator: ',');
    _passwordController = TextEditingController();
    _descriptionController = TextEditingController();
    _payInBloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _passwordController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<PayInBloc, PayInState>(
            bloc: _payInBloc,
            listener: (context, state) {
              if (state is PayInStateSuccessSubmit){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context,state.message),
                );
                _amountController.updateValue(0);
                _descriptionController.clear();
                _passwordController.clear();
              }
              if (state is PayInStateFailedSubmit){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context,state.message),
                );
                _passwordController.clear();
              }
            },
            child:
                BlocBuilder<PayInBloc, PayInState>(builder: (context, state) {
              if (state is PayInStateSubmitting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
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
                            "Put your money into the wallet",
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
                          borderRadius: BorderRadius.all(Radius.circular(20.h)),
                          color: mainColor),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(
                                height: 50.h,
                                child: Text("${_checkError(state)}"),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                alignment: Alignment.topLeft,
                                child: Text("Amount of money (VND)",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        labelStyle:
                                        TextStyle(color: Colors.white)),
                                    controller: _amountController,
                                    cursorColor: Colors.white,
                                    onSubmitted: (String val) {},
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                alignment: Alignment.topLeft,
                                child: Text("Description",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: _descriptionController,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                        ),
                                        labelStyle:
                                        TextStyle(color: Colors.white)),
                                    onSubmitted: (String val) {},
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(8.h),
                                alignment: Alignment.topLeft,
                                child: Text("Password",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "your password . . .",
                                      hintStyle: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white70),
                                      icon: new Icon(
                                        Icons.lock_outline,
                                        color: Colors.white70,
                                        size: 24.h,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  obscureText: true,
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  controller: _passwordController,
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            Size(double.infinity, 55.h)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () {
                                  _pressedSubmitButton();
                                },
                                child: Text(
                                  "Cast",
                                  style: TextStyle(
                                      fontSize: 18.sp,
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
              );
            })),
      ),
    );
  }

  void _pressedSubmitButton() {
    bool check = true;
    if (_amountController.numberValue < 100000 || _amountController.numberValue > 99999999) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Error'),
                content:
                    Text('Value of mone must be > 100.000 and <100.000.000'),
              ));
      check = false;
    }
    if (_passwordController.text == ""){
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Password cant be null'),
          ));
      check = false;
    }
    if (check == true)
      BlocProvider.of<PayInBloc>(context).add(PayInEventSubmitting(
        _passwordController.text,
        _amountController.numberValue,
        _descriptionController.text));
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  String _checkError(PayInState state)
  {
    if (state is PayInStateError)
      return state.message;
    return "";
  }

  Widget _buildPopupDialog(BuildContext context, String message) {
    return new AlertDialog(
      title: const Text('Transaction Notify:'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${message}"),
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
