import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pharmacy_app/data/queries.dart';
import 'package:pharmacy_app/models/product.dart';
import 'package:pharmacy_app/models/transaction.dart';
import 'package:expandable/expandable.dart';

import 'item_tile.dart';

class TransactionDetailsPage extends StatefulWidget {
  Transaction transaction;

  TransactionDetailsPage(this.transaction);

  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  GlobalKey<ScaffoldState> _transactionDetailsKey = GlobalKey<ScaffoldState>();

  List<Widget> itemTileDetails = List<Widget>();
  Map<Product, int> itemList = Map<Product, int>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // itemList.clear();
    // itemTileDetails.clear();
  }

  @override
  Widget build(BuildContext context) {
    itemTileDetails.add(
      Dash(
        length: MediaQuery.of(context).size.width -
            MediaQuery.of(context).padding.left -
            MediaQuery.of(context).padding.right -
            78,
        dashColor: Colors.grey,
      ),
    );

    itemTileDetails.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Rp. " + widget.transaction.totalPrice.toString(),
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      key: _transactionDetailsKey,
      appBar: AppBar(
        // backgroundColor: const Color(0xff1f83fe),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
        ),
        title: Text(
          "#" + widget.transaction.transactionId.toString() + " Details",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 15,
                right: 10,
                left: 10,
                bottom: 8,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Transaction ID",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "#" + widget.transaction.transactionId.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Rp. " + widget.transaction.totalPrice.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  FontAwesomeIcons.calendar,
                                  size: 15,
                                ),
                              ),
                              Expanded(
                                  flex: 8, child: Text(widget.transaction.date))
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Icon(
                                    FontAwesomeIcons.clock,
                                    size: 15,
                                  )),
                              Expanded(
                                  flex: 8, child: Text(widget.transaction.time))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.payment,
                                  size: 15,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text("Payment Method"),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Icon(
                                  Icons.person,
                                  size: 18,
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text("Operator"),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 17),
                child: Card(
                  elevation: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 15, bottom: 8),
                          child: Text(
                            "Item Sold Details",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        // Dash(length: MediaQuery.of(context).size.width - 45,),

                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 15, left: 15, bottom: 10),
                            child: Query(
                              options: QueryOptions(
                                document: Queries.getSoldProduct,
                                variables: {
                                  'listProduct':
                                      widget.transaction.listProductId
                                },
                              ),
                              builder: (QueryResult result,
                                  {VoidCallback refetch, FetchMore fetchMore}) {
                                if (result.errors != null) {
                                  return Text(result.errors.toString());
                                }
                                if (result.loading) {
                                  return Center(
                                    child: Loading(
                                      indicator: BallPulseIndicator(),
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                  );
                                }
                                List<dynamic> fetchedProduk =
                                    result.data['produk'];

                                return ListView.builder(
                                  itemCount: fetchedProduk.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    dynamic responseData = fetchedProduk[index];
                                    Product product = Product(
                                        responseData['serial_id'],
                                        responseData['nama_produk'],
                                        responseData['harga'],
                                        responseData['stocks'][0]['stock'],
                                        DateTime.parse(responseData['exp']),
                                        responseData['rak_produks'][0]['rak']);
                                    return ItemTile(
                                        product,
                                        widget
                                            .transaction.listProductQty[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: RaisedButton(
                elevation: 0,
                onPressed: () {
                  _transactionDetailsKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text("Print Receipt"),
                    ),
                  );
                },
                color: Colors.blue[800],
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Print Receipt",
                      style: TextStyle(color: Colors.white, letterSpacing: 3),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                splashColor: Colors.white,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                highlightColor: Colors.white,
                icon: Icon(
                  Icons.share,
                  color: Colors.blue[800],
                ),
                onPressed: () {
                  _transactionDetailsKey.currentState.showSnackBar(SnackBar(
                    content: Text("Share Receipt"),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
