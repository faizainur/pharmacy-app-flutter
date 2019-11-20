import 'transaction.dart';
class TransactionBundle{
  String date;
  List<Transaction> transactionList;

  int _totalIncome;

  TransactionBundle(this.date, this.transactionList);

  int get totalIncomePerDay {
    _totalIncome = 0;
    transactionList.forEach((v) {
      _totalIncome += v.totalPrice;
    });
    return _totalIncome;
  }
}