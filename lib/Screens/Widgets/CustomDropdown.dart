import 'package:exchangex/blocs/ExchangeBloc.dart';
import 'package:exchangex/blocs/events/ExchangeEvent.dart';
import 'package:exchangex/blocs/states/exchangeState.dart';
import 'package:exchangex/models/currency_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget dropdownButtonChooseCurrency(ExchangeStateSuccessFetched currentState,
    BuildContext context, bool isTop) {
  bool check =
      (isTop && currentState.isSell) || (!isTop && !currentState.isSell)
          ? true
          : false;

  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(left: 20),
        child: DropdownButton<String>(
          //------------------------------------- Handle the value of different currency selections at DropdownButton on the top
          value: check
              ? currentState.chosenCurrency.currency
              : currentState.currenciesList[3].currency,
          onChanged: (String? val) {
            if ((check && (val != currentState.chosenCurrency.currency)) ||
                (!check && (val != "VND"))) {
              if (val == "VND" || val == currentState.chosenCurrency.currency) {
                BlocProvider.of<ExchangeBloc>(context).add(
                    ExchangeEventSwapCurrency(
                        currentState.user,
                        currentState.currenciesList,
                        currentState.chosenCurrency,
                        0,
                        0,
                        currentState.isSell));
              } else {
                Currency temp = currentState.currenciesList[1];
                for (int i = 0; i < currentState.currenciesList.length; i++) {
                  if (val == currentState.currenciesList[i].currency)
                    temp = currentState.currenciesList[i];
                }
                //-----------------------------------------------------------------------------------------------
                BlocProvider.of<ExchangeBloc>(context).add(
                    ExchangeEventCurrencyChange(
                        currentState.user,
                        currentState.currenciesList,
                        temp,
                        0,
                        0,
                        currentState.isSell));
              }
            }
          },

          items: currentState.currenciesList.map((Currency val) {
            return new DropdownMenuItem<String>(
              value: val.currency,
              child: new Text(val.currency),
            );
          }).toList(),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 16),
        child: check
            ? SvgPicture.asset(
                'assets/images/ic_${currentState.chosenCurrency.currency}.svg',
                height: 16,
                width: 16,
              )
            : SvgPicture.asset(
                'assets/images/ic_VND.svg',
                height: 16,
                width: 16,
              ),
      ),
    ],
  );
}
