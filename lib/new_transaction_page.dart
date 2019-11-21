import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pharmacy_app/product_list_card.dart';
import 'package:pharmacy_app/products_page.dart';
import 'package:pharmacy_app/sort_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'product_list_widget.dart';
import 'package:rubber/rubber.dart';

class NewTransactionPage extends StatefulWidget {
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
  final searchController = TextEditingController();

  /* List of Chip Widgets */
  static List<Widget> listChipWidget = List<Widget>();
  static List<String> listChipLabel = List<String>();

  /* List of checkbox labels and values 
      This list used for building checkboxes when SortBottomSheet showed*/
  static List<String> listCategoriesName = ['Generic', 'Obat batuk'];
  static List<bool> listCategoriesVal = [false, true];

  static int incrementor = 1;

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

    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
    listProductItemCards.add(ProductCard());
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
      // setState(() => {searchController.text = barcodeScanRes});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SlidingUpPanel(
        panel: Center(
          child: Text("data"),
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
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(right: 8),
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
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: RaisedButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              hoverElevation: 0,
                              focusElevation: 0,
                              highlightElevation: 0,
                              highlightColor: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: const Color(0xffF3F2F7),
                                    width: 2.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              disabledElevation: 0,
                              elevation: 0,
                              child: SizedBox(
                                height: 57,
                                child: Container(
                                  padding: EdgeInsets.only(left: 0),
                                  child: Icon(
                                    Icons.sort,
                                    size: 35,
                                    color: const Color(0xffF3F2F7),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                showSortBottomSheet();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Wrap(
                      spacing: 2,
                      children: listChipWidget,
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 0,
                      right: 0,
                      top: 0,
                    ),
                    child: ListView.builder(
                      itemCount: listProductItemCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: listProductItemCards[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        minHeight: 90,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        collapsed: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: <Widget>[
              Divider(
                color: Colors.grey,
                thickness: 3,
                indent: MediaQuery.of(context).size.width / 2.5,
                endIndent: MediaQuery.of(context).size.width / 2.5,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Total",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            Text(
                              "Rp. " + 5000.toString(),
                              style: TextStyle(
                                color: const Color(0xff0B3557),
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: RaisedButton(
                          color: Colors.blue[900],
                          child: Center(
                            child: Text(
                              "Add Bill",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {},
                        ),
                      ),
                    )
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
