import 'package:exchangex/models/user_model.dart';

Future<User> getUser() async{
  Balance balance1 = new Balance("USD", 120);
  Balance balance2 = new Balance("JPY", 213);
  Balance balance3 = new Balance("VND", 5000000);
  Balance balance4 = new Balance("EUR", 20);
  List<Balance> balanceList = <Balance>[];
  balanceList.add(balance3);
  balanceList.add(balance1);
  balanceList.add(balance2);
  balanceList.add(balance4);
  ExchangeHistory history1 = new ExchangeHistory("USD", "1-9-2020", 230000, 10, 23000,true);
  ExchangeHistory history2 = new ExchangeHistory("EUR", "2-9-2020", 526666, 20, 26333.33,false);
  ExchangeHistory history3 = new ExchangeHistory("JPY", "11-9-2020", 2030300, 10000, 203.03,true);
  ExchangeHistory history4 = new ExchangeHistory("USD", "20-9-2020", 2355500, 100, 23555,false);
  ExchangeHistory history5 = new ExchangeHistory("JPY", "21-9-2020", 2030300, 10000, 203.03,true);
  ExchangeHistory history6 = new ExchangeHistory("USD", "30-9-2020", 2355500, 100, 23555,true);

  List<ExchangeHistory> exchangeHistoryList = <ExchangeHistory>[];
  exchangeHistoryList.add(history1);
  exchangeHistoryList.add(history2);
  exchangeHistoryList.add(history3);
  exchangeHistoryList.add(history4);
  exchangeHistoryList.add(history5);
  exchangeHistoryList.add(history6);

  PayInHistory payInHistory1 = new PayInHistory("20/9/2020", 2000000, "nop tien di du hoc");
  PayInHistory payInHistory2 = new PayInHistory("21/9/2020", 20000000, "nop tien dau tu chung khoan co phieu . . . ");
  PayInHistory payInHistory3 = new PayInHistory("20/9/2020", 200000000, "nop tien mua nha tai my houston");
  List<PayInHistory> payInHitoryList = <PayInHistory>[];
  payInHitoryList.add(payInHistory1);
  payInHitoryList.add(payInHistory2);
  payInHitoryList.add(payInHistory3);

  User user = new User("user1", "285098789", "Luu Van Hieu", "hieu27@gmail.com", "0333222111", balanceList,exchangeHistoryList,payInHitoryList);

  return user;
 }

User virtualUser(){
  Balance balance1 = new Balance("USD", 120);
  Balance balance2 = new Balance("JPY", 213);
  Balance balance3 = new Balance("VND", 5000000);
  Balance balance4 = new Balance("EUR", 20);
  List<Balance> balanceList = <Balance>[];
  balanceList.add(balance3);
  balanceList.add(balance2);
  balanceList.add(balance1);
  balanceList.add(balance4);
  ExchangeHistory history1 = new ExchangeHistory("USD", "1-9-2020", 230000, 10, 23000,true);
  ExchangeHistory history2 = new ExchangeHistory("EUR", "2-9-2020", 526666, 20, 26333.33,false);
  ExchangeHistory history3 = new ExchangeHistory("JPY", "11-9-2020", 2030300000, 10000, 203.03,true);
  ExchangeHistory history4 = new ExchangeHistory("USD", "20-9-2020", 2355500, 100, 23555,false);
  ExchangeHistory history5 = new ExchangeHistory("JPY", "21-9-2020", 2030300, 10000, 203.03,true);
  ExchangeHistory history6 = new ExchangeHistory("USD", "30-9-2020", 2355500, 100, 23555,true);
  List<ExchangeHistory> exchangeHistoryList = <ExchangeHistory>[];
  exchangeHistoryList.add(history1);
  exchangeHistoryList.add(history2);
  exchangeHistoryList.add(history3);
  exchangeHistoryList.add(history4);
  exchangeHistoryList.add(history5);
  exchangeHistoryList.add(history6);

  PayInHistory payInHistory1 = new PayInHistory("20/9/2020", 2000000, "nop tien di du hoc");
  PayInHistory payInHistory2 = new PayInHistory("21/9/2020", 20000000, "nop tien dau tu chung khoan co phieu . . . ");
  PayInHistory payInHistory3 = new PayInHistory("20/9/2020", 200000000, "nop tien mua nha tai my houston");
  List<PayInHistory> payInHitoryList = <PayInHistory>[];
  payInHitoryList.add(payInHistory1);
  payInHitoryList.add(payInHistory2);
  payInHitoryList.add(payInHistory3);

  User user = new User("user1", "285098789", "Luu Van Hieu", "hieu27@gmail.com", "0333222111", balanceList,exchangeHistoryList,payInHitoryList);
  return user;
}