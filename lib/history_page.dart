import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/product.dart';
import 'package:pharmacy_app/models/transaction.dart';
import 'history_item.dart';
import 'models/trasactions_perday_bundle.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HistoryPage extends StatefulWidget {
  // Test SSH

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Transaction transaction1;
  Transaction transaction2;

  Product obatBatuk = new Product('OB1', 'Obat Batuk', 5, 'Meredakan batuk');
  Product paracetamol = new Product('PR1', 'Obat Demam', 25, 'Meredakan Demam');

  // Transaction List Dummy Data
  List<Transaction> listTransaction1;
  List<Transaction> listTransaction2;

  List<Product> listProductSold1;
  List<Product> listProductSold2;

  TransactionBundle bundle1;
  TransactionBundle bundle2;

  List<TransactionBundle> bundleList = new List<TransactionBundle>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    listProductSold1 = [obatBatuk, obatBatuk, paracetamol];

    listProductSold2 = [paracetamol, paracetamol, obatBatuk, obatBatuk];

    transaction1 = new Transaction(
        21, '25 Nov 2019', '12.00', listProductSold1, 'Tunai', 24000);
    transaction2 = new Transaction(
        35, '28 Nov 2019', '12.50', listProductSold2, 'OVO', 120000);

    listTransaction1 = [
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction2,
      transaction1,
      transaction2,
      transaction2,
      transaction1,
      transaction2,
    ];

    listTransaction2 = [
      transaction1,
      transaction2,
      transaction1,
      transaction2,
      transaction1,
      transaction2,
    ];

    bundle1 = TransactionBundle("12 November 2019", listTransaction2);
    bundle2 = TransactionBundle("15 Desember 2019", listTransaction1);

    bundleList.add(bundle1);
    bundleList.add(bundle2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
            itemCount: bundleList.length,
            itemBuilder: (BuildContext context, int index) {
              List<Widget> listTiles = List<Widget>();

              bundleList[index].transactionList.forEach(
                (v) {
                  listTiles.add(HistoryItem(v));
                },
              );

              print(index.toString() +
                  bundleList[index].totalIncomePerDay.toString());

              return StickyHeader(
                header: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  color: Colors.grey[200],
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          bundleList[index].date,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Rp. " +
                                bundleList[index].totalIncomePerDay.toString(),
                            style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                content: Wrap(
                  children: listTiles,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
