import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_app/data/queries.dart';

class AddNewProductPage extends StatefulWidget {
  GlobalKey<ScaffoldState> _keyScaf;
  AddNewProductPage(this._keyScaf);
  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final productNameController = TextEditingController();

  final serialIdController = TextEditingController();

  final hargaController = TextEditingController();

  final expController = TextEditingController();

  final rakController = TextEditingController();

  final stokController = TextEditingController();

  GlobalKey<ScaffoldState> _scafKey = GlobalKey<ScaffoldState>();

  String expDate;

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafKey,
      appBar: AppBar(
        title: Text(
          "Add New Product",
          style: TextStyle(color: Colors.grey[800]),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[800],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: <Widget>[
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 2.5, color: const Color(0xffF3F2F7)),
                  ),
                  labelText: "Serial ID",
                  errorText: _validate ? 'This field cannot be empty' : null,
                ),
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 2.5, color: const Color(0xffF3F2F7)),
                  ),
                  labelText: "Product Name",
                  errorText: _validate ? 'This field cannot be empty' : null,
                ),
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 2.5, color: const Color(0xffF3F2F7)),
                  ),
                  labelText: "Price",
                  errorText: _validate ? 'This field cannot be empty' : null,
                ),
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 2.5, color: const Color(0xffF3F2F7)),
                  ),
                  labelText: "Stock",
                  errorText: _validate ? 'This field cannot be empty' : null,
                ),
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
                  focusColor: Colors.grey[700],
                  hoverColor: Colors.grey[700],
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                  hintText: "No. Rak",
                  // hintStyle: TextStyle(color: const Color(0xffF3F2F7)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 2.5, color: const Color(0xffF3F2F7)),
                  ),
                  labelText: "No. Rak",
                  errorText: _validate ? 'This field cannot be empty' : null,
                ),
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
                      DatePicker.showDatePicker(context, showTitleActions: true,
                          onConfirm: (date) {
                        expController.text =
                            DateFormat("dd-MM-yyyy").format(date);
                        expDate = date.toString();
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
                    borderSide:
                        const BorderSide(color: Colors.blueAccent, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        width: 2.5, color: const Color(0xffF3F2F7)),
                  ),
                  labelText: "Expired Date",
                  errorText: _validate ? 'This field cannot be empty' : null,
                ),
                autofocus: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.red,
                child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Mutation(
                options: MutationOptions(document: Queries.insertData),
                builder: (RunMutation runMutation, QueryResult result) {
                  return RaisedButton(
                    elevation: 0,
                    onPressed: () {
                      if (serialIdController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else if (productNameController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else if (rakController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else if (stokController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else if (hargaController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else if (expController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else {
                        runMutation({
                          'serialId': int.parse(serialIdController.text),
                          'namaProduk': productNameController.text,
                          'stock': int.parse(stokController.text),
                          'exp': expDate,
                          'harga': int.parse(hargaController.text),
                          'rak': int.parse(rakController.text)
                        });
                      }
                    },
                    color: Colors.blue[800],
                    child: SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          "Add New Product",
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 3),
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
                    widget._keyScaf.currentState.showSnackBar(SnackBar(
                      content: Text("Insert Data Successfully"),
                      duration: Duration(seconds: 1),
                    ));
                  } else {
                    _scafKey.currentState.showSnackBar(SnackBar(
                      content: Text("Insert Data Unsuccessfull"),
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
