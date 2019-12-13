import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pharmacy_app/data/queries.dart';
import 'package:pharmacy_app/item_tile.dart';
import 'package:pharmacy_app/product_details.dart';
import 'package:pharmacy_app/product_list_card.dart';
import 'package:pharmacy_app/products_page.dart';
import 'package:pharmacy_app/sliding_panel.dart';
import 'package:pharmacy_app/sort_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'models/product.dart';
import 'product_list_widget.dart';
import 'package:rubber/rubber.dart';
import 'package:string_validator/string_validator.dart';

class NewTransactionPage extends StatefulWidget {
  GlobalKey<ScaffoldState> _keyTransaction;
  NewTransactionPage(this._keyTransaction);
  @override
  _NewTransactionPageState createState() => _NewTransactionPageState();
}

class _NewTransactionPageState extends State<NewTransactionPage>
    with SingleTickerProviderStateMixin {
  static String barcodeScanRes;
  static bool barcodeScanStatus;

  RubberAnimationController _controller;

  static List<Widget> listProductItemCards = List<Widget>();
  GlobalKey _searchTextField;
  GlobalKey<ScaffoldState> _scaffKey = GlobalKey<ScaffoldState>();

  final searchController = TextEditingController();

  /* List of Chip Widgets */
  static List<Widget> listChipWidget = List<Widget>();
  static List<String> listChipLabel = List<String>();

  /* List of checkbox labels and values 
      This list used for building checkboxes when SortBottomSheet showed*/
  static List<String> listCategoriesName = ['Generic', 'Obat batuk'];
  static List<bool> listCategoriesVal = [false, true];

  static int incrementor = 1;

  bool _panelVisible = false;

  // AnimatedContainer variables
  double _addButtonWidth;
  double _addButtonHeight;

  bool searchEnable = false;
  String keyString = "";
  int keyInt = 0;

  List<Product> soldProduct = List<Product>();
  List<int> soldProductId = List<int>();
  List<int> soldProductQty = List<int>();
  int totalHarga = 0;
  int totalProduk = 0;

  // var addBillButton = RaisedButton(
  //   color: Colors.blue[900],
  //   child: Center(
  //     child: Text(
  //       "Add Bill",
  //       style: TextStyle(color: Colors.white, fontSize: 20),
  //     ),
  //   ),
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //   onPressed: () {
  //     String str = parseSoldProductArray(soldProductId, soldProductQty);
  //     print(str);
  //   },
  // );

  @override
  void initState() {
    // TODO: implement initState
    _controller = RubberAnimationController(
      vsync: this, // Thanks to the mixin
    );
    super.initState();

    if (listChipWidget.isNotEmpty) {
      listChipWidget.clear();
      listChipLabel.clear();
      listCategoriesName.forEach(
        (v) {
          int index = listCategoriesName.indexOf(v);
          bool checkboxVal = listCategoriesVal[index];
          String label = "$v " + checkboxVal.toString();
          listChipLabel.add(label);
          listChipWidget.add(
            Chip(
              label: Text(label),
              deleteIcon: Icon(Icons.close),
              onDeleted: () {
                setState(
                  () {
                    String lblChip = label;
                    int index = listChipLabel.indexOf(lblChip);
                    listChipWidget.removeAt(index);
                    listChipLabel.remove(lblChip);
                  },
                );
              },
            ),
          );
        },
      );
    }
    listProductItemCards.clear();

    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());
    // listProductItemCards.add(ProductCard());

    _addButtonWidth = 150;
    _addButtonHeight = 80;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  void scanBarcode() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#cedc00", "Cancel", true, ScanMode.DEFAULT);
    if (barcodeScanRes != "-1") {
      setState(() => {searchController.text = barcodeScanRes});
    }
  }

  void showSortBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return SortBottomSheet(listCategoriesName, listCategoriesVal);
      },
    ).then(
      (value) {
        // Scaffold.of(context).showSnackBar(SnackBar(
        //   content: Text("data"),
        // ));
        listChipLabel.clear();
        listChipWidget.clear();
        setState(
          () {
            listCategoriesName.forEach(
              (v) {
                int index = listCategoriesName.indexOf(v);
                bool checkboxVal = listCategoriesVal[index];
                String label = "$v " + checkboxVal.toString();
                listChipLabel.add(label);
                listChipWidget.add(
                  Chip(
                    label: Text(label),
                    deleteIcon: Icon(Icons.close),
                    onDeleted: () {
                      setState(
                        () {
                          String lblChip = label;
                          int index = listChipLabel.indexOf(lblChip);
                          listChipWidget.removeAt(index);
                          listChipLabel.remove(lblChip);
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String parseSoldProductArray(List<int> serialId, List<int> qtyList) {
    String str = "{";
    serialId.forEach((id) {
      int index = serialId.indexOf(id);
      int qty = qtyList[index];
      if (serialId.indexOf(id) == serialId.length - 1) {
        str = str + "{$id,$qty}}";
      } else {
        str = str + "{$id,$qty},";
      }
    });
    return str;
  }

  @override
  Widget build(BuildContext context) {
    print(soldProductId);
    print(soldProductQty);
    totalHarga = 0;
    soldProduct.forEach((product) {
      int qty = soldProductQty[soldProduct.indexOf(product)];
      totalHarga += (product.price * qty);
    });
    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "New Transaction",
          style: TextStyle(color: Colors.grey[800], fontSize: 20),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SlidingUpPanel(
            onPanelSlide: (double st) {
              if (st == 0.0) {
                setState(() {
                  _panelVisible = false;
                });
              } else if (st == 1.0) {
                setState(() {
                  _panelVisible = true;
                  _addButtonWidth = MediaQuery.of(context).size.width;
                  _addButtonHeight = 80;
                });
              } else {
                setState(() {
                  _panelVisible = false;
                  _addButtonWidth = 150;
                });
              }
            },
            onPanelClosed: () {
              setState(() {
                _addButtonWidth = 150;
              });
            },
            minHeight: 90,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            body: Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 5,
                            left: 10,
                            right: 10,
                            bottom: 5,
                          ),
                          child: Container(
                            // margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: searchController,
                              key: _searchTextField,
                              textAlign: TextAlign.left,
                              cursorColor: Colors.grey[300],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey[700],
                              ),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: scanBarcode,
                                  icon: Image(
                                    image: AssetImage(
                                        'images/001-barcode-scanner.png'),
                                    color: Colors.grey,
                                  ),
                                  focusColor: Colors.grey,
                                  iconSize: 25,
                                  hoverColor: Colors.grey,
                                ),
                                focusColor: Colors.grey[700],
                                hoverColor: Colors.grey[700],
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: const Color(0xffF3F2F7),
                                  size: 30,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 17),
                                hintText: "Search product",
                                hintStyle: TextStyle(
                                    color: const Color(0xffF3F2F7)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: const Color(0xffF3F2F7),
                                      width: 2.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2.5,
                                      color: const Color(0xffF3F2F7)),
                                ),
                              ),
                              autofocus: false,
                              onSubmitted: (String key) {
                                if (key.isEmpty) {
                                  setState(() {
                                    searchEnable = false;
                                  });
                                } else if (key.isNotEmpty) {
                                  if (isNumeric(key)) {
                                    keyInt = int.parse(key);
                                    keyString = "";
                                  } else {
                                    keyString = "%" + key + "%";
                                    keyInt = 0;
                                  }
                                  setState(() {
                                    searchEnable = true;
                                  });
                                }
                              },
                              onChanged: (String key) {
                                if (key.isEmpty) {
                                  setState(() {
                                    searchEnable = false;
                                  });
                                } else if (key.isNotEmpty) {
                                  if (isNumeric(key)) {
                                    keyInt = int.parse(key);
                                    keyString = "";
                                  } else {
                                    keyString = "%" + key + "%";
                                    keyInt = 0;
                                  }
                                  setState(() {
                                    searchEnable = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          right: 0,
                          top: 0,
                        ),
                        child: Query(
                          options: searchEnable
                              ? QueryOptions(
                                  document: Queries.searchData,
                                  variables: {
                                      'keyString': keyString,
                                      'keyInt': keyInt
                                    })
                              : QueryOptions(document: Queries.fetchAll()),
                          builder: (QueryResult result,
                              {VoidCallback refetch, FetchMore fetchMore}) {
                            if (result.errors != null) {
                              return Text(result.errors.toString());
                            }
                            if (result.loading) {
                              return Center(
                                    child: Loading(
                                      indicator: BallPulseIndicator(),
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  );
                            }
                            List<dynamic> fetchedProduk = result.data['produk'];
                            return ListView.builder(
                              itemCount: fetchedProduk.length,
                              itemBuilder: (context, index) {
                                dynamic responseData = fetchedProduk[index];
                                Product product = Product(
                                    responseData['serial_id'],
                                    responseData['nama_produk'],
                                    responseData['harga'],
                                    responseData['stocks'][0]['stock'],
                                    DateTime.parse(responseData['exp']),
                                    responseData['rak_produks'][0]['rak']);
                                return InkWell(
                                  child: ProductCard(product),
                                  onTap: () {
                                    // setState(
                                    //   () {
                                    //     if (soldProductId
                                    //         .contains(product.serialId)) {
                                    //       soldProductQty[soldProductId
                                    //           .indexOf(product.serialId)] += 1;
                                    //     } else {
                                    //       soldProductId.add(product.serialId);
                                    //       soldProduct.add(product);
                                    //       soldProductId.add(1);
                                    //     }
                                    //   },
                                    // );
                                    print(product.serialId);
                                    // soldProductQty.clear();
                                    //     soldProduct.clear();
                                    setState(() {
                                      if (!soldProductId
                                          .contains(product.serialId)) {
                                        print("Tidak Ada");
                                        soldProduct.add(product);
                                        soldProductId.add(product.serialId);
                                        soldProductQty.add(1);
                                        // totalHarga += product.price;
                                      } else {
                                        print("Ada");
                                        soldProductQty[soldProductId
                                            .indexOf(product.serialId)] += 1;
                                        // totalHarga += product.price;
                                      }
                                    });
                                    // print(soldProductId);
                                    // print(soldProductQty);
                                  },
                                  splashColor: Colors.grey,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            panel: Container(
              margin: EdgeInsets.only(bottom: 65),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        child: Container(
                          color: Colors.grey,
                        ),
                        height: 3,
                        width: MediaQuery.of(context).size.width / 7,
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      opacity: _panelVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 50),
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 10,
                          left: 10,
                          top: 0,
                          bottom: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        soldProduct.length.toString() +
                                            " Product",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.calculator,
                                          size: 20,
                                          color: Colors.grey[700],
                                        ),
                                        splashColor: Colors.grey,
                                        onPressed: () {
                                          final snackBar = SnackBar(
                                            content: Text('Yay! A SnackBar!'),
                                            action: SnackBarAction(
                                              label: 'Undo',
                                              onPressed: () {
                                                // Some code to undo the change.
                                              },
                                            ),
                                          );
                                          // Find the Scaffold in the widget tree and use
                                          // it to show a SnackBar.
                                          _scaffKey.currentState
                                              .showSnackBar(snackBar);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: ListView.builder(
                                    itemCount: soldProduct.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.all(8),
                                        height: 60,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    soldProduct[index]
                                                        .productName,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      "Rp. " +
                                                          soldProduct[index]
                                                              .price
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 6,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          Container(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    right: 10),
                                                            child: Text(
                                                              "Rp. " +
                                                                  soldProduct[
                                                                          index]
                                                                      .price
                                                                      .toString() +
                                                                  " x " +
                                                                  soldProductQty[
                                                                          index]
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                          .grey[
                                                                      700]),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: FlatButton(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 5),
                                                              color:
                                                                  Colors.white,
                                                              splashColor:
                                                                  Colors.white,
                                                              child: Icon(
                                                                Icons.edit,
                                                                size: 18,
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                // Scaffold.of(context).showSnackBar(
                                                                //   SnackBar(
                                                                //     content: Text("Edit Data"),
                                                                //     duration: Duration(milliseconds: 500),
                                                                //   ),
                                                                // );/
                                                                await showDialog(
                                                                    context:
                                                                        context,
                                                                        barrierDismissible: false,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return EditItemDialog(
                                                                          soldProductQty[
                                                                              index]);
                                                                    }).then(
                                                                  (val) {
                                                                    setState(
                                                                      () {
                                                                        if (val != null) {
                                                                          soldProductQty[index] =
                                                                            val;
                                                                        }
                                                                      },
                                                                    );
                                                                  },
                                                                );

                                                                // print("Data");
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: FlatButton(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 5),
                                                              color:
                                                                  Colors.white,
                                                              splashColor:
                                                                  Colors.white,
                                                              child: Icon(
                                                                Icons.delete,
                                                                size: 18,
                                                                color: Colors
                                                                    .grey[700],
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  soldProductQty
                                                                      .removeAt(
                                                                          index);
                                                                  soldProductId
                                                                      .removeAt(
                                                                          index);
                                                                  soldProduct
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.grey),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Rp. " + totalHarga.toString(),
                                        style: TextStyle(
                                            color: const Color(0xff0B3557),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            collapsed: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: <Widget>[
                  // Divider(
                  //   color: Colors.grey,
                  //   thickness: 3,
                  //   indent: MediaQuery.of(context).size.width / 2.5,
                  //   endIndent: MediaQuery.of(context).size.width / 2.5,
                  // ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                Text(
                                  "Rp. " + totalHarga.toString(),
                                  style: TextStyle(
                                    color: const Color(0xff0B3557),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(flex: 3, child: Container())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                alignment: Alignment.bottomLeft,
                duration: Duration(milliseconds: 75),
                height: 70,
                width: _addButtonWidth,
                padding: const EdgeInsets.all(8),
                child: Mutation(
                  options: MutationOptions(document: Queries.addTransaction),
                  builder: (RunMutation runMutation, QueryResult result) {
                    return RaisedButton(
                      color: Colors.blue[900],
                      child: Center(
                        child: Text(
                          "Add Bill",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        String str = parseSoldProductArray(
                            soldProductId, soldProductQty);
                        runMutation({
                          'jam': DateFormat.Hm().format(DateTime.now()),
                          'tanggal':
                              DateFormat("yyyy-MM-dd").format(DateTime.now()),
                          'soldProduct': str,
                          'totalHarga': totalHarga
                        });
                      },
                    );
                  },
                  update: (Cache cache, QueryResult result) {
                    if (result.hasErrors) {
                      print(result.errors);
                    }
                    return cache;
                  },
                  onCompleted: (dynamic resultData) {
                    if (resultData.isNotEmpty) {
                      Navigator.pop(context);
                      widget._keyTransaction.currentState.showSnackBar(SnackBar(
                        content: Text("Add New Transaction Successfully"),
                        duration: Duration(seconds: 1),
                      ));
                    } else {
                      _scaffKey.currentState.showSnackBar(SnackBar(
                        content: Text("Unable to add new transaction."),
                      ));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditItemDialog extends StatefulWidget {
  int qty;

  EditItemDialog(this.qty);
  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  final editItemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    editItemController.text = widget.qty.toString();
    return AlertDialog(
      title: Text("Edit Item"),
      content: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  if (widget.qty != 0) {
                    widget.qty -= 1;
                  }
                });
              },
              child: Icon(Icons.remove),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: editItemController,
            ),
          ),
          Expanded(
            flex: 1,
            child: FlatButton(
              onPressed: () {
                setState(() {
                  setState(() {
                    widget.qty += 1;
                  });
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "CANCEL",
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(
            "APPLY",
          ),
          onPressed: () {
            Navigator.pop(context, widget.qty);
          },
        ),
      ],
    );
  }
}
/* 
Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 30,
                  height: 20,
                  child: FlatButton(
                    // padding: EdgeInsets.all(8),
                    color: Colors.transparent,
                    disabledColor: Colors.transparent,
                    splashColor: Colors.grey[200],
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.blue[700]),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.blue[700],
                      size: 18,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    keyboardType: TextInputType.number,
                  ),
                ),
                ButtonTheme(
                  minWidth: 30,
                  height: 20,
                  child: FlatButton(
                    // padding: EdgeInsets.all(8),
                    color: Colors.transparent,
                    disabledColor: Colors.transparent,
                    splashColor: Colors.grey[200],
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.blue[700]),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.blue[700],
                      size: 18,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ), */
