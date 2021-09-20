import 'package:exchangex/Screens/ExchangeScreen.dart';
import 'package:exchangex/Screens/HistoryScreen.dart';
import 'package:exchangex/Screens/TabControl.dart';
import 'package:exchangex/blocs/ExchangeBloc.dart';
import 'package:exchangex/blocs/LoginBloc.dart';
import 'package:exchangex/util/loginlogic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchangex/Screens/LoginScreen.dart';

import 'blocs/events/ExchangeEvent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "ExchangeX",
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ExchangeBloc>(create: (BuildContext context) => ExchangeBloc()),
          BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc(logic: SimpleLoginLogic()),)
        ],
        child: MyTabControl()
      )
    );
  }
}
