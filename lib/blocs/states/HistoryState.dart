import 'package:equatable/equatable.dart';
import 'package:exchangex/models/balance_model.dart';
import 'package:exchangex/models/exchange_history_model.dart';
import 'package:exchangex/models/payin_history_model.dart';

abstract class HistoryState extends Equatable{
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryStateInitial extends HistoryState{}
class HistoryStateFetching extends HistoryState{}
class HistoryStateError extends HistoryState{}
class HistoryStateSuccessFetched extends HistoryState{

  List<ExchangeHistory> exchangeHistoryList;
  List<PayInHistory> payInHistoryList;
  List<Balance> balanceList;

  HistoryStateSuccessFetched({required this.exchangeHistoryList, required this.payInHistoryList,required this.balanceList});

  List<Object> get props => [exchangeHistoryList,payInHistoryList,balanceList];
}