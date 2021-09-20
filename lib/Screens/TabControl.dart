import 'package:exchangex/Screens/ExchangeScreen.dart';
import 'package:exchangex/Screens/HistoryScreen.dart';
import 'package:exchangex/Screens/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: [
            Container(child: ExchangeScreen()),
            Container(child: HistoryScreen()),
            Container(child: Icon(Icons.directions_bike)),
          ],
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
