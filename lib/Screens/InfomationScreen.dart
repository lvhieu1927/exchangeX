import 'package:exchangex/Screens/LoginScreen.dart';
import 'package:exchangex/blocs/InformationBloc.dart';
import 'package:exchangex/blocs/LoginBloc.dart';
import 'package:exchangex/blocs/events/InformationEvent.dart';
import 'package:exchangex/blocs/states/InformationState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  Color secondColor = Color(0xff8A85AA);
  Color mainColor = Color(0xff3A3D46);
  late InformationBloc _informationBloc;

  @override
  void initState() {
    _informationBloc = BlocProvider.of(context);
    _informationBloc.add(InformationEventFetching());
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, "assets/images/ic_exchangex.svg"),
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<InformationBloc, InformationState>(
            builder: (context, state) {
          if (state is InformationStateSuccessFetched)
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Stack(
                children: [
                  Container(
                    width: 360.w,
                    height: 640.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 0.0),
                        // 10% of the width, so there are ten blinds.
                        colors: <Color>[Color(0xff00092B), Color(0xff8C8D3A)],
                        // red to yellow
                        tileMode: TileMode
                            .repeated, // repeats the gradient over the canvas
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, top: 10.h),
                          child: Container(
                            width: double.infinity,
                            height: 190.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                                // 10% of the width, so there are ten blinds.
                                colors: <Color>[mainColor, secondColor],
                                // red to yellow
                                tileMode: TileMode
                                    .repeated, // repeats the gradient over the canvas
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.h)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.w, top: 20.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/ic_exchangex.svg",
                                        height: 24,
                                        width: 24,
                                        fit: BoxFit.fill,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        "ExchangeX",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      new Spacer(),
                                      Text(
                                        "${state.user.fullName.toUpperCase()}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 30.w, bottom: 10.h),
                                  child: Text(
                                    "Total balance:",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "~ ${NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(state.totalBalance)}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Center(
                                  child: Text(
                                    "****   ****   ****   ${state.user.identifyCard.substring(state.user.identifyCard.length - 4, state.user.identifyCard.length)} ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              moneyTag(
                                  Colors.black87,
                                  state.user.balanceList[0].currency,
                                  NumberFormat.currency(
                                          locale: 'vi',
                                          customPattern: '#,###.#',
                                          decimalDigits: 2)
                                      .format(state
                                          .user.balanceList[0].balanceValue)
                                      .toString()),
                              moneyTag(
                                  Colors.purpleAccent,
                                  state.user.balanceList[1].currency,
                                  NumberFormat.currency(
                                          locale: 'vi',
                                          customPattern: '#,###.#',
                                          decimalDigits: 2)
                                      .format(state
                                          .user.balanceList[1].balanceValue)
                                      .toString()),
                              moneyTag(
                                  Colors.pinkAccent,
                                  state.user.balanceList[2].currency,
                                  NumberFormat.currency(
                                          locale: 'vi',
                                          customPattern: '#,###.#',
                                          decimalDigits: 2)
                                      .format(state
                                          .user.balanceList[2].balanceValue)
                                      .toString()),
                              moneyTag(
                                  Colors.amberAccent,
                                  state.user.balanceList[3].currency,
                                  NumberFormat.currency(
                                          locale: 'vi',
                                          customPattern: '#,###.#',
                                          decimalDigits: 2)
                                      .format(state
                                          .user.balanceList[3].balanceValue)
                                      .toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(mainColor),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(150.w, 50.h)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.h),
                                ))),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute<LoginScreen>(
                                  builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<LoginBloc>(context),
                                    child: LoginScreen(),
                                  ),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Log out",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          if (state is InformationStateError) {
            return Container(
              width: 360.w,
              height: 640.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 0.0),
                  // 10% of the width, so there are ten blinds.
                  colors: <Color>[Color(0xff00092B), Color(0xff8C8D3A)],
                  // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: Center(child: Text("Something went Wrong . . . ")),
            );
          }
          return Container(
            width: 360.w,
            height: 640.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0),
                // 10% of the width, so there are ten blinds.
                colors: <Color>[Color(0xff00092B), Color(0xff8C8D3A)],
                // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ),
    );
  }

  Widget moneyTag(Color color, String currency, String balance) {
    return Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
          width: 330.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.h)),
            color: secondColor,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  SvgPicture.asset(
                    'assets/images/ic_${currency}.svg',
                    height: 32.h,
                    width: 32.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Balance ${currency}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  new Spacer(),
                  Text(
                    "${balance}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    width: 30.w,
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 17.h,
                width: 340.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.h),
                      bottomRight: Radius.circular(20.h)),
                  color: color,
                ),
              )
            ],
          ),
        ));
  }
}
