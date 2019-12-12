import 'product.dart';

class Transaction {
  int transactionId;
  String date;
  String time;
  List<int> listProductId;
  List<int> listProductQty;
  int totalPrice;
  String operator;

  Transaction(this.transactionId, this.date, this.time, this.listProductId, this.listProductQty, this.totalPrice);
}
