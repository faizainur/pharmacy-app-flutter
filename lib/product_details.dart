import 'package:avatar_letter/avatar_letter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/data/queries.dart';

import 'models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  Product product;
  ProductDetailsPage(this.product, this._key);
  GlobalKey<ScaffoldState> _key;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final productNameController = TextEditingController();

  final serialIdController = TextEditingController();

  final hargaController = TextEditingController();

  final expController = TextEditingController();

  final rakController = TextEditingController();

  final stokController = TextEditingController();

  GlobalKey<ScaffoldState> _scafKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController.text = widget.product.productName;
    serialIdController.text = widget.product.serialId.toString();
    hargaController.text = widget.product.price.toString();
    expController.text =
        DateFormat('dd-MM-yyyy').format(widget.product.exp).toString();
    stokController.text = widget.product.productStock.toString();
    rakController.text = widget.product.rak.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafKey,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                height: 100,
                child: Center(
                  child: AvatarLetter(
                    size: 80,
                    backgroundColor: Colors.grey[700],
                    fontSize: 50,
                    upperCase: true,
                    numberLetters: 2,
                    letterType: LetterType.Rectangle,
                    text: widget.product.productName,
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.only(top: 20, right: 8, left: 8, bottom: 8),
              child: TextField(
                controller: serialIdController,
                // key: _searchTextField,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey[300],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   onPressed: scanBarcode,
                    //   icon: Image(
                    //     image: AssetImage('images/001-barcode-scanner.png'),
                    //     color: Colors.grey,
                    //   ),
                    //   focusColor: Colors.grey,
                    //   iconSize: 25,
                    //   hoverColor: Colors.grey,
                    // ),Text
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    hintText: "Serial ID",
                    // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                    labelText: "Serial ID"),
                autofocus: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: productNameController,
                // key: _searchTextField,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey[300],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   onPressed: scanBarcode,
                    //   icon: Image(
                    //     image: AssetImage('images/001-barcode-scanner.png'),
                    //     color: Colors.grey,
                    //   ),
                    //   focusColor: Colors.grey,
                    //   iconSize: 25,
                    //   hoverColor: Colors.grey,
                    // ),Text
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    hintText: "Product Name",
                    // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                    labelText: "Product Name"),
                autofocus: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: hargaController,
                // key: _searchTextField,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey[300],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   onPressed: scanBarcode,
                    //   icon: Image(
                    //     image: AssetImage('images/001-barcode-scanner.png'),
                    //     color: Colors.grey,
                    //   ),
                    //   focusColor: Colors.grey,
                    //   iconSize: 25,
                    //   hoverColor: Colors.grey,
                    // ),Text
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    hintText: "Price",
                    // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                    labelText: "Price"),
                autofocus: false,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: stokController,
                // key: _searchTextField,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey[300],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   onPressed: scanBarcode,
                    //   icon: Image(
                    //     image: AssetImage('images/001-barcode-scanner.png'),
                    //     color: Colors.grey,
                    //   ),
                    //   focusColor: Colors.grey,
                    //   iconSize: 25,
                    //   hoverColor: Colors.grey,
                    // ),Text
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    hintText: "Stock",
                    // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                    labelText: "Stock"),
                autofocus: false,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: rakController,
                // key: _searchTextField,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey[300],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration(
                    // suffixIcon: IconButton(
                    //   onPressed: scanBarcode,
                    //   icon: Image(
                    //     image: AssetImage('images/001-barcode-scanner.png'),
                    //     color: Colors.grey,
                    //   ),
                    //   focusColor: Colors.grey,
                    //   iconSize: 25,
                    //   hoverColor: Colors.grey,
                    // ),Text
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    hintText: "No. Rak",
                    // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                    labelText: "No. Rak"),
                autofocus: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: expController,
                // key: _searchTextField,
                textAlign: TextAlign.left,
                cursorColor: Colors.grey[300],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            currentTime: widget.product.exp, onConfirm: (date) {
                          expController.text =
                              DateFormat("dd-MM-yyyy").format(date);
                          widget.product.exp = date;
                          print(widget.product.exp);
                        });
                      },
                      icon: Icon(FontAwesomeIcons.calendar),
                      focusColor: Colors.grey,
                      iconSize: 25,
                      hoverColor: Colors.grey,
                    ),
                    focusColor: Colors.grey[700],
                    hoverColor: Colors.grey[700],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                    hintText: "Expired Date",
                    // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.blueAccent, width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                    labelText: "Expired Date"),
                autofocus: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Mutation(
                  options: MutationOptions(document: Queries.deleteData),
                  builder: (RunMutation runMutation, QueryResult result) {
                    return FlatButton(
                      onPressed: () {
                        //
                        showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete Data?"),
                                  content: const Text(
                                      "After you press OK, data will be no longer available."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: const Text("CANCEL"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    FlatButton(
                                      child: const Text("DELETE"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        runMutation({
                                          'serialId': widget.product.serialId,
                                        });
                                      },
                                    )
                                  ],
                                );
                              });
                      },
                      color: Colors.grey[50],
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            "Delete Product",
                            style: TextStyle(
                              color: Colors.red,
                              letterSpacing: 1,
                              // decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
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
                      widget._key.currentState.showSnackBar(SnackBar(
                        content: Text("Delete Data Successfully"),
                        duration: Duration(seconds: 1),
                      ));
                    } else {
                      _scafKey.currentState.showSnackBar(SnackBar(
                        content: Text("Delete Data Unsuccessfull"),
                      ));
                    }
                  },
                ),
                Mutation(
                  options: MutationOptions(document: Queries.updateData),
                  builder: (RunMutation runMutation, QueryResult result) {
                    return RaisedButton(
                      elevation: 0,
                      // onPressed: (){
                      //   _scafKey.currentState.showSnackBar(
                      //     SnackBar(content: Text("data"),)
                      //   );
                      // },
                      onPressed: () => runMutation({
                        'oldSerialId': widget.product.serialId,
                        'newSerialId': int.parse(serialIdController.text),
                        'namaProduk': productNameController.text,
                        'harga': int.parse(hargaController.text),
                        'rak': int.parse(rakController.text),
                        'stock': int.parse(stokController.text),
                        'exp': widget.product.exp.toString()
                      }),
                      color: Colors.blue[800],
                      child: SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            "Edit Product",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 3),
                          ),
                        ),
                      ),
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
                      widget._key.currentState.showSnackBar(SnackBar(
                        content: Text("Edit Data Successfully"),
                        duration: Duration(seconds: 1),
                      ));
                    } else {
                      _scafKey.currentState.showSnackBar(SnackBar(
                        content: Text("Edit Data Unsuccessfull"),
                      ));
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
