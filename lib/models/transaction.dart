import 'product.dart';

class Transaction {
  int transactionId;
  String date;
  String time;
  List<Product> listProductSold;
  String payMethod;
  int totalPrice;
  String operator;

  Transaction(this.transactionId, this.date, this.time, this.listProductSold,
      this.payMethod, this.totalPrice, this.operator);
}
