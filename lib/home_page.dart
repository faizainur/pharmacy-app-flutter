import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: 10,
        right: 10,
      ),
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    width: 80,
                    height: 130,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text("Monthly Income"),
                            flex: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Divider(
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ),
                          Expanded(
                            flex: 25,
                            child: Center(
                                child: Text("500000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    width: 80,
                    height: 130,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text("Profit"),
                            flex: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Divider(
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                          ),
                          Expanded(
                            flex: 25,
                            child: Center(
                                child: Text("10000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            elevation: 10,
            child: SizedBox(
              height: 285,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 1, child: Text("Recent Transactions")),
                    Expanded(
                      flex: 1,
                      child: Divider(
                        thickness: 2,
                        indent: 5,
                        endIndent: 5,
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.attach_money),
                            title: Text("Halloo"),
                            subtitle: Text("data"),
                          ),
                          ListTile(
                            leading: Icon(Icons.attach_money),
                            title: Text("Halloo"),
                            subtitle: Text("data"),
                          ),
                          ListTile(
                            leading: Icon(Icons.attach_money),
                            title: Text("Halloo"),
                            subtitle: Text("data"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
