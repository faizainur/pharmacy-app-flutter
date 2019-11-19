import 'package:flutter/material.dart';
import 'package:pharmacy_app/models/product.dart';
import 'package:pharmacy_app/models/transaction.dart';

class TransactionDetailsPage extends StatefulWidget {
  Transaction transaction;

  TransactionDetailsPage(this.transaction);

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1f83fe),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("# " + widget.transaction.transactionId.toString()),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(widget.transaction.date),
            Text(widget.transaction.payMethod),
            Text(widget.transaction.time),
            Text("Ro. " + widget.transaction.totalPrice.toString()),
            Container(height: 500,
                          child: ListView.builder(
                itemCount: widget.transaction.listProductSold.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(widget.transaction.listProductSold[index].productName);
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
