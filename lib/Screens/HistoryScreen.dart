import 'package:exchangex/Screens/PayInScreen.dart';
import 'package:exchangex/blocs/HistoryBloc.dart';
import 'package:exchangex/blocs/PayinBloc.dart';
import 'package:exchangex/blocs/events/HistoryEvent.dart';
import 'package:exchangex/blocs/states/HistoryState.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late HistoryBloc _historyBloc;

  @override
  void initState() {
    super.initState();
    _historyBloc = BlocProvider.of<HistoryBloc>(context);
    _tabController = TabController(length: 2, vsync: this);
    _historyBloc.add(HistoryEventFetching());

    precachePicture(
      ExactAssetPicture(
          SvgPicture.svgStringDecoder, "assets/images/ic_exchangex.svg"),
      null,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:
            BlocBuilder<HistoryBloc, HistoryState>(builder: (context, state) {
          if (state is HistoryStateSuccessFetched) {
            print("${state.payInHistoryList[0].description}");
            return Stack(children: [
              Container(
                width: 360.w,
                height: 640.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 0.0),
                    // 10% of the width, so there are ten blinds.
                    colors: <Color>[Color(0xff0B1A65), Color(0xffB0B1B6)],
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
                      padding: EdgeInsets.all(9.0.h),
                      child: SvgPicture.asset(
                        "assets/images/ic_exchangex.svg",
                        height: 24,
                        width: 24,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5.h, left: 24.w, right: 24.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12.h, bottom: 12.h, left: 28.w, right: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/images/ic_VND.svg",
                                height: 24,
                                width: 24,
                                fit: BoxFit.fill,
                              ),
                              new Spacer(),
                              Center(
                                child: Text(
                                  "VND ≈ ${NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 0).format(state.balanceList[0].balanceValue)}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0006D2)),
                                ),
                              ),
                              new Spacer(),
                              IconButton(
                                  icon: Icon(
                                    Icons.account_balance_wallet,
                                    color: Colors.blue,
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute<PayInScreen>(
                                        builder: (_) =>
                                            BlocProvider.value(
                                              value: BlocProvider.of<PayInBloc>(context),
                                              child: PayInScreen(),
                                            ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _tabBarCustom(state),
                  ],
                ),
              ),
            ]);
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  Widget _tabBarCustom(HistoryStateSuccessFetched state) {
    return SizedBox(
      height: 465.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 27.w, right: 27.w),
              child: Container(
                height: 35.w,
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
                padding: EdgeInsets.only(top: 26.h),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    _firstTabWidget(state),

                    // second tab bar view widget
                    _secondTabWidget(state),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _secondTabWidget(HistoryStateSuccessFetched state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 26.h),
        child: ListView.separated(
          itemCount: state.payInHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 78.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 14.h),
                      child: Text(
                        "${state.payInHistoryList[index].date}",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xFFB1B1B1)),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 14.w, right: 30.w),
                            child: SvgPicture.asset(
                              "assets/images/ic_VND.svg",
                              height: 24.h,
                              width: 24.w,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 117.w,
                            child: Text(
                              "${state.payInHistoryList[index].description}",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF787676)),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: Text(
                              "VND đ${NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', ).format(state.payInHistoryList[index].value)}",
                              style: TextStyle(
                                  color: Color(0xFF0A9507),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Color(0xFFB4AEAE),
            indent: 0.w,
            endIndent: 16.w,
          ),
        ),
      ),
    );
  }

  Container _firstTabWidget(HistoryStateSuccessFetched state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.h), topLeft: Radius.circular(20.h)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 0.h),
        child: ListView.separated(
          itemCount: state.exchangeHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 70.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h, top: 7.h),
                      child: Text(
                        "${state.exchangeHistoryList[index].date}",
                        style: TextStyle(
                            fontSize: 12.sp, color: Color(0xFFB1B1B1)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 14.w, right: 10.w),
                          child: SvgPicture.asset(
                            "assets/images/ic_${state.exchangeHistoryList[index].currencyExchange}.svg",
                            height: 24,
                            width: 24,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          "${state.exchangeHistoryList[index].currencyExchange}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: SizedBox(
                            width: 98.w,
                            child: Text(
                              "${state.exchangeHistoryList[index].currencyExchange} ~ ${NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(state.exchangeHistoryList[index].ExchangeRateValue)}đ",
                              style: TextStyle(
                                  fontSize: 12.sp, color: Color(0xFF787676)),
                            ),
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.exchangeHistoryList[index].currencyExchange} ${state.exchangeHistoryList[index].isSell != 1 ? "+" : "-"} "
                                "${state.exchangeHistoryList[index].currencyBalanceChangedValue > 0
                                    ? NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(state.exchangeHistoryList[index].currencyBalanceChangedValue)
                                    : NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 2).format(state.exchangeHistoryList[index].currencyBalanceChangedValue * -1)}",
                                style: TextStyle(
                                    color: state.exchangeHistoryList[index]
                                                .isSell ==
                                            1
                                        ? Color(0xFF0A9507)
                                        : Color(0xFFE31616),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "VND ${(state.exchangeHistoryList[index].isSell == 1) ? "+" : "-"} "
                                "${state.exchangeHistoryList[index].vndBalanceChangedValue > 0
                                    ? NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 0).format(state.exchangeHistoryList[index].vndBalanceChangedValue)
                                    : NumberFormat.currency(locale: 'vi', customPattern: '#,###.#', decimalDigits: 0).format(state.exchangeHistoryList[index].vndBalanceChangedValue * -1)}",
                                style: TextStyle(
                                    color: state.exchangeHistoryList[index]
                                                .isSell !=
                                            1
                                        ? Color(0xFF0A9507)
                                        : Color(0xFFE31616),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w,)
                      ],
                    )
                  ],
                ));
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Color(0xFFB4AEAE),
            indent: 0.w,
            endIndent: 16.w,
          ),
        ),
      ),
    );
  }
}
