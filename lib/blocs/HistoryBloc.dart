import 'package:exchangex/blocs/events/HistoryEvent.dart';
import 'package:exchangex/blocs/states/HistoryState.dart';
import 'package:exchangex/models/balance_model.dart';
import 'package:exchangex/models/exchange_history_model.dart';
import 'package:exchangex/models/payin_history_model.dart';
import 'package:exchangex/repositories/balance_repository.dart';
import 'package:exchangex/repositories/history_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryBloc extends Bloc<HistoryEvent,HistoryState>{
  HistoryBloc() : super(HistoryStateInitial());
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    try{
      if (event is HistoryEventFetching){
        yield HistoryStateFetching();

        SharedPreferences prefs = await _prefs;
        String? allData = prefs.getString("allData");
        List<ExchangeHistory> exchangeHistoryList = decodeHistoryExchange(allData);

        List<PayInHistory> payInHistoryList = decodePayInHistory(allData);

        List<Balance> balanceList = decodeBalanceUser(allData);

        yield HistoryStateSuccessFetched(exchangeHistoryList: exchangeHistoryList, payInHistoryList: payInHistoryList, balanceList: balanceList);
      }
    }catch(e)
    {
      debugPrint('exchangedebug: HistoryBloc Printing out the error: ${e.toString()}');
      yield HistoryStateError();
    }
  }
}