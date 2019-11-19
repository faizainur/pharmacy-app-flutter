import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/product.dart';
import 'package:pharmacy_app/models/transaction.dart';
import 'history_item.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Transaction transaction1 = new Transaction(
      21, '25 Nov 2019', '12.00', listProductSold, 'Tunai', 24000);
  Transaction transaction2 = new Transaction(
      35, '28 Nov 2019', '12.50', listProductSold, 'OVO', 120000);
  Product obatBatuk = new Product('OB1', 'Obat Batuk', 5, 'Meredakan batuk');

  static List<Product> listProductSold = List<Product>();
  static List<Transaction> transacionList = List<Transaction>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listProductSold.clear();
    transacionList.clear();

    listProductSold.add(obatBatuk);
    transacionList.add(transaction1);
    transacionList.add(transaction2);

    // print(transaction.listProductSold[0].productName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: BackButton(
          color: Colors.grey[800],
        ),
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Container(
        child: Center(
          child: ListView.builder(
            itemCount: transacionList.length,
            itemBuilder: (BuildContext context, int index) {
              return HistoryItem(transacionList[index]);
            },
          )
        ),
      ),
    );
  }
}
