import 'package:exchangex/Screens/Widgets/BuySellBox.dart';
import 'package:exchangex/Screens/Widgets/CustomDropdown.dart';
import 'package:exchangex/blocs/ExchangeBloc.dart';
import 'package:exchangex/blocs/events/ExchangeEvent.dart';
import 'package:exchangex/blocs/states/exchangeState.dart';
import 'package:exchangex/models/balance_model.dart';
import 'package:exchangex/models/currency_model.dart';
import 'package:exchangex/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

import 'Widgets/CanvasDraw.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  Color mainColor = Color(0xFFB4AEAE);
  Color secondColor = Color(0xFF37385A);
  Color wordGreyColor = Color(0xFF989595);
  late final MoneyMaskedTextController _fromAmountController;
  late final MoneyMaskedTextController _toAmountController;
  var currency = "USD";

  late ExchangeBloc _exchangeBloc;

  @override
  void initState() {
    super.initState();
    _fromAmountController = MoneyMaskedTextController();
    _toAmountController = MoneyMaskedTextController();
    List<Currency> currencyList = <Currency>[];
    Currency currency =
        new Currency(buy_cash: 0, buy_transfer: 0, currency: "0", sell: 0);
    currencyList.add(currency);

    List<Balance> balanceList = <Balance>[];
    User? user = User(
        identifyCard: "0",
        email: "none",
        fullName: "none",
        phoneNumber: "000",
        balanceList: balanceList);

    _exchangeBloc = BlocProvider.of(context);
    _exchangeBloc
        .add(FetchExchangeEvent(user, currencyList, currency, 0, 0, true));
    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, 'assets/images/ic_exchange.svg'),
      null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: BlocListener<ExchangeBloc, ExchangeState>(
        bloc: _exchangeBloc,
        listener: (context, state) {
          if (state is ExchangeStateSuccessFetched){
            if (state.message != "none")
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text(state.message == "fail" ? "Error!" : "Successfully!"),
                      content: new Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          state.message == "fail"
                              ?Text('Something went wrong, please check your connection', style: TextStyle(color: Colors.red, fontSize: 18.sp),)
                              :Text('Transaction successfully!!'),
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
                  },
                );
              }
          }
        },
        child:
            BlocBuilder<ExchangeBloc, ExchangeState>(builder: (context, state) {
          if (state is ExchangeStateSubmittingTransaction ||
              state is ExchangeStateFetching ||
              state is ExchangeStateInitial) {
            return Container(
              width: 360.w,
              height: 640.h,
              padding: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.9, 0.4),
                  // 10% of the width, so there are ten blinds.
                  colors: <Color>[Color(0xff030357), Color(0xffE3E3E5)],
                  // red to yellow
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    child: CustomPaint(
                      painter: OpenPainter33(),
                    ),
                  ),
                  Container(
                    width: 360.w,
                    height: 640.h,
                    child: CustomPaint(
                      painter: OpenPainter11(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    width: 360.w,
                    height: 640.h,
                    child: CustomPaint(
                      painter: OpenPainter22(),
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              ),
            );
          }
          if (state is ExchangeStateFailedFetched) {
            return Container(
              width: 360.w,
              height: 640.h,
              padding: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.9, 0.4),
                  // 10% of the width, so there are ten blinds.
                  colors: <Color>[Color(0xff030357), Color(0xffE3E3E5)],
                  // red to yellow
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    child: CustomPaint(
                      painter: OpenPainter33(),
                    ),
                  ),
                  Container(
                    width: 360.w,
                    height: 640.h,
                    child: CustomPaint(
                      painter: OpenPainter11(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 50),
                    width: 360.w,
                    height: 640.h,
                    child: CustomPaint(
                      painter: OpenPainter22(),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Something Went wrong, Please check your connection and restart the app",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ExchangeStateSuccessFetched) {
            final currentState = state as ExchangeStateSuccessFetched;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Stack(
                  children: [
                    Container(
                      width: 360.w,
                      height: 640.h,
                      padding: EdgeInsets.only(bottom: 50),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.9, 0.4),
                          // 10% of the width, so there are ten blinds.
                          colors: <Color>[Color(0xff030357), Color(0xffE3E3E5)],
                          // red to yellow
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: CustomPaint(
                              painter: OpenPainter33(),
                            ),
                          ),
                          Container(
                            width: 360.w,
                            height: 640.h,
                            child: CustomPaint(
                              painter: OpenPainter11(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 50),
                            width: 360.w,
                            height: 640.h,
                            child: CustomPaint(
                              painter: OpenPainter22(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headOfScreen(currentState),
                        bottomOfScreen(currentState, context),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 8.h, left: 10.w, right: 10.w),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(double.infinity, 50.h)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: () {
                              _pressSubmitButton(state);
                            },
                            child: Text(
                              currentState.isSell
                                  ? 'Sell ${currentState.chosenCurrency.currency}'
                                  : 'Buy ${currentState.chosenCurrency.currency}',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text("Other State"),
          );
        }),
      )),
    );
  }

  //HEAD OF Screen **************************************************************************************************

  Padding headOfScreen(ExchangeStateSuccessFetched currentState) {
    var now = new DateTime.now();
    var formatter = new intl.DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
      child: Container(
          padding: EdgeInsets.only(bottom: 14.0.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 32.w, bottom: 10.h, top: 15.h),
                child: Row(children: [
                  Text(
                    "${formattedDate}",
                    style: TextStyle(
                      color: Color(0xFF37385A),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Color(0xFF37385A),
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 26.w,
                  ),
                  Center(
                    child: Text(
                      currentState.isSell
                          ? "${currentState.chosenCurrency.currency} > VND"
                          : "VND > ${currentState.chosenCurrency.currency}",
                      style: TextStyle(color: Color(0xFFA3A1A1)),
                    ),
                  ),
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BoxBuySell(
                      colorOfBox: Color(0xFF153C94),
                      textOfBox: "Buy",
                      leftOrRightMargin: 1,
                      price: currentState.chosenCurrency.buy_cash),
                  BoxBuySell(
                    colorOfBox: Color(0xFFFB010C),
                    textOfBox: "Sell",
                    leftOrRightMargin: 0,
                    price: currentState.chosenCurrency.sell,
                  ),
                ],
              )
            ],
          )),
    );
  }

  //Bottom OF Screen **************************************************************************************************

  Container bottomOfScreen(
      ExchangeStateSuccessFetched currentState, BuildContext context) {
    _fromAmountController.updateValue(currentState.fromAmount);
    _toAmountController.updateValue(currentState.toAmount);

    _fromAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _fromAmountController.text.length - 2));
    _toAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _toAmountController.text.length - 2));

    num balanceChosenCurrency = 0;
    for (int i = 0; i < currentState.user.balanceList.length; i++) {
      if (currentState.user.balanceList[i].currency ==
          currentState.chosenCurrency.currency)
        balanceChosenCurrency = currentState.user.balanceList[i].balanceValue;
    }

    return Container(
      margin: EdgeInsets.only(top: 12.h, left: 10.w, right: 10.w),
      padding:
          EdgeInsets.only(left: 35.w, right: 35.w, top: 30.w, bottom: 30.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //-------this write in file CustomDropdown
              dropdownButtonChooseCurrency(currentState, context, true),

              SizedBox(
                width: 100,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _fromAmountController,
                  onSubmitted: (String val) {
                    _amountChanged(currentState, true);
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                  "Max: ${currentState.isSell ? currentState.chosenCurrency.currency : "VND"} "
                  "${currentState.isSell ? NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(balanceChosenCurrency) : NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(currentState.user.balanceList[0].balanceValue)}",
                  style: TextStyle(color: wordGreyColor)),
            )
          ]),
          Stack(
            alignment: Alignment.center,
            children: [
              Divider(
                color: Color(0xFFB4AEAE),
                indent: 1.w,
                endIndent: 1.w,
                height: 48,
              ),
              CircleAvatar(
                radius: 16,
                backgroundColor: Color(0xFFB4AEAE),
                child: IconButton(
                  icon: SvgPicture.asset('assets/images/ic_exchange.svg'),
                  onPressed: () {
                    _pressedSwapButton(currentState);
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //-------this write in file CustomDropdown
              dropdownButtonChooseCurrency(currentState, context, false),

              SizedBox(
                width: 100,
                child: TextField(
                  controller: _toAmountController,
                  textAlign: TextAlign.center,
                  onSubmitted: (String val) {
                    _amountChanged(currentState, false);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Max: ${!currentState.isSell ? currentState.chosenCurrency.currency : "VND"} "
                "${currentState.isSell ? NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format((balanceChosenCurrency * currentState.chosenCurrency.sell)) : NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format((currentState.user.balanceList[0].balanceValue / currentState.chosenCurrency.buy_cash))}",
                style: TextStyle(color: wordGreyColor),
              ),
            )
          ]),
          Divider(
            color: Color(0xFFB4AEAE),
            indent: 1.w,
            endIndent: 1.w,
            height: 48,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Available Portfolio",
              style: TextStyle(color: wordGreyColor),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(left: 75.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${currentState.chosenCurrency.currency}",
                        style: TextStyle(color: secondColor),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "${NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(balanceChosenCurrency)}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: secondColor),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.w, bottom: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "VND",
                        style: TextStyle(color: secondColor),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Text(
                            "${NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(currentState.user.balanceList[0].balanceValue)}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: secondColor),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _pressedSwapButton(ExchangeStateSuccessFetched currentState) {
    BlocProvider.of<ExchangeBloc>(context).add(ExchangeEventSwapCurrency(
        currentState.user,
        currentState.currenciesList,
        currentState.chosenCurrency,
        _fromAmountController.numberValue,
        _toAmountController.numberValue,
        currentState.isSell));
  }

  void _amountChanged(
      ExchangeStateSuccessFetched currentState, bool isFromAmount) {
    print("AmountChanging ${isFromAmount.toString()}");
    BlocProvider.of<ExchangeBloc>(context).add(ExchangeEventAmountChanged(
        currentState.user,
        currentState.currenciesList,
        currentState.chosenCurrency,
        _fromAmountController.numberValue,
        _toAmountController.numberValue,
        currentState.isSell,
        isFromAmount));
  }

  void _pressSubmitButton(ExchangeStateSuccessFetched state) {
    bool isLegal = false;
    if (_fromAmountController.numberValue != 0 ||
        _toAmountController.numberValue != 0) {
      double fromAmount = _fromAmountController.numberValue;
      double toAmount = _toAmountController.numberValue;
      if (fromAmount > 1 || toAmount > 1) {
        isLegal = true;
      }
    }
    if (isLegal) {
      BlocProvider.of<ExchangeBloc>(context).add(ExchangeEventSubmitTransaction(
        state.user,
        state.currenciesList,
        state.chosenCurrency,
        _fromAmountController.numberValue,
        _toAmountController.numberValue,
        state.isSell,
      ));
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Error'),
                content: Text('Please check the amount number'),
              ));
    }
  }
}
