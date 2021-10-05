import 'package:exchangex/Screens/ExchangeScreen.dart';
import 'package:exchangex/Screens/HistoryScreen.dart';
import 'package:exchangex/Screens/InfomationScreen.dart';
import 'package:exchangex/blocs/HistoryBloc.dart';
import 'package:exchangex/blocs/InformationBloc.dart';
import 'package:exchangex/blocs/PayinBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTabControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: menu(),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<HistoryBloc>(
                create: (BuildContext context) => HistoryBloc()),
            BlocProvider<InformationBloc>(
                create: (BuildContext context) => InformationBloc()),
            BlocProvider<PayInBloc>(
                create: (BuildContext context) => PayInBloc()),
          ],
          child: TabBarView(
            children: [
              Container(child: ExchangeScreen()),
              Container(child: HistoryScreen()),
              Container(child: InformationScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFF00092B),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            icon: Icon(Icons.euro_symbol),
          ),
          Tab(
            icon: Icon(Icons.account_balance_wallet),
          ),
          Tab(
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
