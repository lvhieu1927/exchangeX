import 'package:exchangex/models/user_model.dart';
import 'package:exchangex/repositories/user_respository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<ExchangeHistory> exchangeHistoryList =
      virtualUser().exchangeHistoryList;
  final List<PayInHistory> payInHistoryList = virtualUser().payInHistoryList;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var deviceWidth = queryData.size.width / 360;
    var deviceHeight = queryData.size.height / 640;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(children: [
          Image.asset(
            "assets/images/img_background.png",
            height: deviceHeight * 640,
            width: deviceWidth * 360,
            fit: BoxFit.fill,
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(deviceHeight * 9.0),
                  child: SvgPicture.asset(
                    "assets/images/ic_exchangex.svg",
                    height: 24,
                    width: 24,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 5 * deviceHeight,
                      left: 24 * deviceWidth,
                      right: 24 * deviceWidth),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 12 * deviceHeight,
                          bottom: 12 * deviceHeight,
                          left: 28 * deviceWidth,
                          right: 20 * deviceWidth),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/ic_VND.svg",
                            height: 24,
                            width: 24,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: deviceHeight * 180,
                            child: Center(
                              child: Text(
                                "VND ≈ 2,500,000,000,000",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0006D2)),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.account_balance_wallet,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                _tabBarCustom(deviceHeight, deviceWidth),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _tabBarCustom(double deviceHeight, double deviceWidth) {
    return SizedBox(
      height: 488 * deviceHeight,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 20 * deviceHeight),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 27 * deviceWidth, right: 27 * deviceWidth),
              child: Container(
                height: 35 * deviceWidth,
                decoration: BoxDecoration(
                  color: Color(0xFF37385A),
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ),
                      color: Color(0xFF00092B),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    tabs: [
                      Tab(
                        text: 'Exchange',
                      ),
                      Tab(
                        text: 'Income',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // tab bar view here
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 26 * deviceHeight),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    _firstTabWidget(deviceWidth, deviceHeight),

                    // second tab bar view widget
                    _secondTabWidget(deviceWidth, deviceHeight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _secondTabWidget(double deviceWidth, double deviceHeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16 * deviceWidth, top: 26 * deviceHeight),
        child: ListView.separated(
          itemCount: payInHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 78,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 14 * deviceHeight),
                      child: Text(
                        "${payInHistoryList[index].date}",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFFB1B1B1)),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 14 * deviceWidth,
                                right: 30 * deviceWidth),
                            child: SvgPicture.asset(
                              "assets/images/ic_VND.svg",
                              height: 24,
                              width: 24,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 120 * deviceWidth,
                            child: Text(
                              "${payInHistoryList[index].description}",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF787676)),
                            ),
                          ),
                          SizedBox(
                            width: 140 * deviceWidth,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8*deviceWidth),
                              child: Text(
                              "VND + đ${intl.NumberFormat.decimalPattern().format(payInHistoryList[index].value)}",
                              style: TextStyle(
                                color: Color(0xFF0A9507),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }

  Container _firstTabWidget(double deviceWidth, double deviceHeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 16 * deviceWidth, top: 26 * deviceHeight),
        child: ListView.separated(
          itemCount: exchangeHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 78,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 14 * deviceHeight),
                      child: Text(
                        "${exchangeHistoryList[index].date}",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFFB1B1B1)),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 14 * deviceWidth,
                                right: 10 * deviceWidth),
                            child: SvgPicture.asset(
                              "assets/images/ic_${exchangeHistoryList[index].currencyExchange}.svg",
                              height: 24,
                              width: 24,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "${exchangeHistoryList[index].currencyExchange}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 114 * deviceWidth,
                            child: Center(
                              child: Text(
                                "1 ${exchangeHistoryList[index].currencyExchange} ~ ${exchangeHistoryList[index].ExchangeRateValue}đ",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFF787676)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 140 * deviceWidth,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${exchangeHistoryList[index].currencyExchange} ${exchangeHistoryList[index].isSell ? "+" : "-"} "
                                    "${intl.NumberFormat.decimalPattern().format(exchangeHistoryList[index].currencyBalanceChangedValue)}",
                                    style: TextStyle(
                                        color: exchangeHistoryList[index].isSell
                                            ? Color(0xFF0A9507)
                                            : Color(0xFFE31616),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "VND ${!exchangeHistoryList[index].isSell ? "+" : "-"} "
                                    "${intl.NumberFormat.decimalPattern().format(exchangeHistoryList[index].vndBalanceChangedValue)}",
                                    style: TextStyle(
                                        color:
                                            !exchangeHistoryList[index].isSell
                                                ? Color(0xFF0A9507)
                                                : Color(0xFFE31616),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}
