import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pharmacy_app/add_new_product_page.dart';
import 'package:pharmacy_app/addnewproductwodget.dart';
import 'package:pharmacy_app/product_details.dart';
import 'config/client.dart';
import 'data/queries.dart';
import 'models/product.dart';
import 'product_list_card.dart';
import 'sort_dialog.dart';
import 'sort_bottom_sheet.dart';
import 'package:pharmacy_app/services/shared_preferences_service.dart';
import 'package:intl/intl.dart';
import 'package:string_validator/string_validator.dart';

class ProductsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ProductsPage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static List<Widget> listProductItemCards = List<Widget>();
  GlobalKey _searchTextField;
  static String barcodeScanRes;
  static bool barcodeScanStatus;
  final searchController = TextEditingController();

  /* List of Chip Widgets */
  static List<Widget> listChipWidget = List<Widget>();
  static List<String> listChipLabel = List<String>();

  /* List of checkbox labels and values 
      This list used for building checkboxes when SortBottomSheet showed*/
  static List<String> listCategoriesName = ['Generic', 'Obat batuk'];
  static List<bool> listCategoriesVal = [false, true];

  bool searchEnable = false;
  String keyString = "";
  int keyInt = 0;


  void checkInternt() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fillList();
    checkInternt();

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

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
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
                    hintStyle:
                        TextStyle(color: const Color(0xffF3F2F7)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: const Color(0xffF3F2F7), width: 2.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          width: 2.5, color: const Color(0xffF3F2F7)),
                    ),
                  ),
                  autofocus: false,
                  onSubmitted: (String key) {
                    if (key.isEmpty){
                      setState(() {
                        searchEnable = false;
                      });
                    } else if (key.isNotEmpty) {
                      if (isNumeric(key)){
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
                    if (key.isEmpty){
                      setState(() {
                        searchEnable = false;
                      });
                    } else if (key.isNotEmpty) {
                      if (isNumeric(key)){
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
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 0,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Query(
                        options: searchEnable ? 
                              QueryOptions(
                                document: Queries.searchData,
                                variables: {
                                  'keyString' : keyString,
                                  'keyInt' : keyInt
                                }) : 
                                QueryOptions(document: Queries.fetchAll()),
                        builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailsPage(product, widget.scaffoldKey);
                                      },
                                    ),
                                  );
                                },
                                splashColor: Colors.grey,
                              );
                            },
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FloatingActionButton(
                            child: Icon(Icons.add),
                            backgroundColor: Colors.blueAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return AddNewProductPage(widget.scaffoldKey);
                                }),
                              );
                              /* if (this.mounted) {
                                setState(
                                  () => listProductItemCards.add(
                                    InkWell(
                                      child: ProductCard(),
                                      onTap: () {},
                                    ),
                                  ),
                                );
                              } else {
                                print("State not found");
                              } */
                            },
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void showSortDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return SortDialog(
              listCategoriesName: listCategoriesName,
              listCategoriesVal: listCategoriesVal);
        }).then(
      (val) {
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
}
