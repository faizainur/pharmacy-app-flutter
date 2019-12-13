import 'product.dart';

class Transaction {
  int transactionId;
  String date;
  String time;
  List<int> listProductId;
  List<int> listProductQty;
  int totalPrice;

  // Constructor
  Transaction(
    this.transactionId,
    this.date,
    this.time,
    this.listProductId,
    this.listProductQty,
    this.totalPrice,
  );
}
