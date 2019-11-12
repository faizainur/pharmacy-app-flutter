import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pharmacy_app/addnewproductwodget.dart';

class ProductsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ProductsPage({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Widget> listItem = [
    AddNewProductButton(
      onPressed: () {},
    ),
    Card(
      child: SizedBox(
        height: 100,
        width: 100,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
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
                            textAlign: TextAlign.left,
                            cursorColor: Colors.grey[300],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[300],
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.grey[350],
                              hoverColor: Colors.grey[350],
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
                            widget.scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Data"),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    disabledElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    disabledColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    color: Color(0xfff6f8fa),
                    elevation: 0,
                    hoverElevation: 1,
                    textColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: DottedBorder(
                        dashPattern: [3],
                        color: Colors.blueAccent,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(5),
                        strokeWidth: 2,
                        child: Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Add new device',
                                  // style: dateTextStyle.copyWith(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      widget.scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Data"),
                        ),
                      );
                    },
                  ),
                ),
                AddNewProductButton(
                  onPressed: () {
                    widget.scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text("Data"),
                      ),
                    );
                  },
                )
              ],
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 0, right: 0, top: 25),
                  child: ListView.builder(
                    itemCount: listItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: listItem[index],
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
