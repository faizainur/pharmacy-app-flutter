import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharmacy_app/models/transaction.dart';
import 'trasaction_details.dart';

class HistoryItem extends StatefulWidget {
  Transaction transaction;

  HistoryItem(this.transaction);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  void onTapItem(Transaction transaction) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          /* TODO : Navigate to transaction details page, passing transaction data */
          print(widget.transaction.listProductId);
          print(widget.transaction.listProductQty);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return TransactionDetailsPage(widget.transaction);
              },
            ),
          );
        },
        child: Container(
          height: 80,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.receipt,
                    color: Colors.blueAccent[100],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rp. " + widget.transaction.totalPrice.toString(),
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "# " + widget.transaction.transactionId.toString(),
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          // child: Text(widget.transaction.payMethod),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Center(
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(widget.transaction.time))))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
