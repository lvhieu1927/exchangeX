import 'package:exchangex/Screens/Widgets/BuySellBox.dart';
import 'package:exchangex/Screens/Widgets/CustomDropdown.dart';
import 'package:exchangex/blocs/ExchangeBloc.dart';
import 'package:exchangex/blocs/events/ExchangeEvent.dart';
import 'package:exchangex/blocs/states/exchangeState.dart';
import 'package:exchangex/models/currency_model.dart';
import 'package:exchangex/models/user_model.dart';
import 'package:exchangex/repositories/user_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  _ExchangeScreenState createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  Color mainColor = Color(0xFFB4AEAE);
  Color secondColor = Color(0xFF37385A);
  Color wordGreyColor = Color(0xFF989595);
  final TextEditingController _fromAmountController = TextEditingController();
  final TextEditingController _toAmountController = TextEditingController();
  var currency = "USD";

  late ExchangeBloc _exchangeBloc;

  @override
  void initState() {
    super.initState();
    List<Currency> currencyList = <Currency>[];
    Currency currency =
        new Currency(buy_cash: 0, buy_transfer: 0, currency: "0", sell: 0);
    currencyList.add(currency);
    User user = virtualUser();
    _exchangeBloc = BlocProvider.of(context);
    _exchangeBloc
        .add(FetchExchangeEvent(user, currencyList, currency, "", "", true));
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width / 360;
    var deviceHeight = queryData.size.height / 640;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child:
          BlocBuilder<ExchangeBloc, ExchangeState>(builder: (context, state) {
        if (state is ExchangeStateInitial || state is ExchangeStateFetching) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ExchangeStateFailedFetched) {
          return Center(
            child: Text("Failed to load Currencies"),
          );
        }
        if (state is ExchangeStateSuccessFetched) {
          final currentState = state as ExchangeStateSuccessFetched;
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/img_background.png",
                  height: deviceHeight * 640,
                  width: deviceWidth * 360,
                  fit: BoxFit.fill,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headOfScreen(deviceHeight, deviceWidth, currentState),
                    bottomOfScreen(
                        deviceHeight, deviceWidth, currentState, context),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12 * deviceHeight,
                          left: 12 * deviceWidth,
                          right: 12 * deviceWidth),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(double.infinity, 45 * deviceHeight)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: () {},
                        child: Text(
                          currentState.isSell
                              ? 'Sell ${currentState.chosenCurrency.currency}'
                              : 'Buy ${currentState.chosenCurrency.currency}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Center(
          child: Text("Other State"),
        );
      })),
    );
  }

  //HEAD OF Screen **************************************************************************************************

  Padding headOfScreen(double deviceHeight, double deviceWidth,
      ExchangeStateSuccessFetched currentState) {
    var now = new DateTime.now();
    var formatter = new intl.DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    return Padding(
      padding: EdgeInsets.only(
          top: 20 * deviceHeight,
          left: 12 * deviceWidth,
          right: 12 * deviceWidth),
      child: Container(
          padding: EdgeInsets.only(bottom: 14.0 * deviceHeight),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.only(
                    left: 32 * deviceWidth, bottom: deviceWidth * 10,top: deviceWidth*15),
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
                    width: 3 * deviceWidth,
                  ),
                  Icon(
                    Icons.calendar_today,
                    color: Color(0xFF37385A),
                    size: 16.0,
                  ),
                  SizedBox(
                    width: 26 * deviceWidth,
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
                      deviceWidth: deviceWidth,
                      deviceHeight: deviceHeight,
                      colorOfBox: Color(0xFF153C94),
                      textOfBox: "Buy",
                      leftOrRightMargin: 1,
                      price: currentState.chosenCurrency.buy_cash),
                  BoxBuySell(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
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

  Container bottomOfScreen(double deviceHeight, double deviceWidth,
      ExchangeStateSuccessFetched currentState, BuildContext context) {
    _fromAmountController.text = currentState.fromAmount;
    _toAmountController.text = currentState.toAmount;

    _fromAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _fromAmountController.text.length));
    _toAmountController.selection = TextSelection.fromPosition(
        TextPosition(offset: _toAmountController.text.length));

    num balanceChosenCurrency = 0;
    for (int i = 0; i < currentState.user.balanceList.length; i++) {
      if (currentState.user.balanceList[i].currency ==
          currentState.chosenCurrency.currency)
        balanceChosenCurrency = currentState.user.balanceList[i].balanceValue;
    }

    return Container(
      margin: EdgeInsets.only(
          top: 14 * deviceHeight,
          left: 12 * deviceWidth,
          right: 12 * deviceWidth),
      padding: EdgeInsets.only(
          left: 35 * deviceWidth,
          right: 35 * deviceWidth,
          top: 30 * deviceWidth,
          bottom: 30 * deviceWidth),
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
              child: Text("Max: ${currentState.isSell ? currentState.chosenCurrency.currency : "VND"} "
                  "${currentState.isSell ? balanceChosenCurrency : currentState.user.balanceList[0].balanceValue}",
                  style: TextStyle(color: wordGreyColor)),
            )
          ]),
          Stack(
            alignment: Alignment.center,
            children: [
              Divider(
                color: Color(0xFFB4AEAE),
                indent: 1 * deviceWidth,
                endIndent: 1 * deviceWidth,
                height: 48,
              ),
              IconButton(
                onPressed: () {
                  _pressedSwapButton(currentState);
                },
                icon: SvgPicture.asset(
                  'assets/images/ic_exchange.svg',
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
                    "${currentState.isSell ? (balanceChosenCurrency*currentState.chosenCurrency.sell).toStringAsFixed(0)
                    : (currentState.user.balanceList[0].balanceValue/currentState.chosenCurrency.buy_cash).toStringAsFixed(3)}",
                style: TextStyle(color: wordGreyColor),
              ),
            )
          ]),
          Divider(
            color: Color(0xFFB4AEAE),
            indent: 1 * deviceWidth,
            endIndent: 1 * deviceWidth,
            height: 48,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "Available Portfolio",
              style: TextStyle(color: wordGreyColor),
            )
          ]),
          Padding(
            padding: EdgeInsets.only(left: deviceWidth * 75),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10 * deviceWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${currentState.chosenCurrency.currency}",
                        style: TextStyle(color: secondColor),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10 * deviceWidth),
                          child: Text(
                            "${intl.NumberFormat.decimalPattern().format(balanceChosenCurrency)}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: secondColor),
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10 * deviceWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "VND",
                        style: TextStyle(color: secondColor),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10 * deviceWidth),
                          child: Text(
                            "${intl.NumberFormat.decimalPattern().format(currentState.user.balanceList[0].balanceValue)}",
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
        _fromAmountController.text,
        _toAmountController.text,
        currentState.isSell));
  }

  void _amountChanged(
      ExchangeStateSuccessFetched currentState, bool isFromAmount) {
    print("AmountChanging ${isFromAmount.toString()}");
    BlocProvider.of<ExchangeBloc>(context).add(ExchangeEventAmountChanged(
        currentState.user,
        currentState.currenciesList,
        currentState.chosenCurrency,
        _fromAmountController.text,
        _toAmountController.text,
        currentState.isSell,
        isFromAmount));
  }
}
