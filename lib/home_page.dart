import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import 'data/queries.dart';

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
        top: 9,
        left: 10,
        right: 10,
      ),
      child: ListView(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
        children: <Widget>[
          Card(
            elevation: 2,
            child: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Today",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                  fontSize: 25),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Query(
                              options: QueryOptions(
                                document: Queries.getTodayIncome,
                                variables: {
                                  'tanggal': DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now())
                                  // 'tanggal' : "2019-12-12"
                                },
                              ),
                              builder: (QueryResult result,
                                  {VoidCallback refetch, FetchMore fetchMore}) {
                                int todayIncome;

                                if (result.hasErrors) {
                                  todayIncome = 0;
                                }
                                if (result.loading) {
                                  return Text(
                                    "Rp. 0",
                                    style: TextStyle(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                    textAlign: TextAlign.right,
                                  );
                                }
                                todayIncome = result.data['transaksi_aggregate']
                                    ['aggregate']['sum']['total_harga'];
                                if (todayIncome == null) {
                                  todayIncome = 0;
                                }
                                if (todayIncome == null ||
                                    result.data == null) {
                                  todayIncome = 0;
                                }
                                return Text(
                                  "Rp. " + todayIncome.toString(),
                                  style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                  textAlign: TextAlign.end,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Total Income",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  // fontWeight: FontWeight.w500,
                                  color: Colors.grey[800],
                                  fontSize: 13),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Query(
                                options:
                                    QueryOptions(document: Queries.totalIncome),
                                builder: (QueryResult result,
                                    {VoidCallback refetch,
                                    FetchMore fetchMore}) {
                                  int totalIncome;
                                  if (result.hasErrors) {
                                    totalIncome = 0;
                                  }
                                  if (result.loading) {
                                    return Text(
                                      "Rp. 0",
                                      style: TextStyle(
                                          color: Colors.blue[800],
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                      textAlign: TextAlign.right,
                                    );
                                  }
                                  totalIncome =
                                      result.data['transaksi_aggregate']
                                          ['aggregate']['sum']['total_harga'];
                                  if (totalIncome == null) {
                                    totalIncome = 0;
                                  }
                                  // List<dynamic> fetchedData = result.data['transaksi_aggregate'];
                                  return Text(
                                    "Rp. " + totalIncome.toString(),
                                    style: TextStyle(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                    textAlign: TextAlign.right,
                                  );
                                },
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Card(
          //   elevation: 2,
          //   child: SizedBox(
          //     height: 285,
          //     child: Padding(
          //       padding: EdgeInsets.all(10),
          //       child: Column(
          //         children: <Widget>[
          //           Expanded(flex: 1, child: Text("Recent Transactions")),
          //           Expanded(
          //             flex: 1,
          //             child: Divider(
          //               height: 2,
          //               indent: 5,
          //               endIndent: 5,
          //             ),
          //           ),
          //           Expanded(
          //             flex: 9,
          //             child: ListView(
          //               physics: NeverScrollableScrollPhysics(),
          //               children: <Widget>[
          //                 ListTile(
          //                   leading: Icon(Icons.attach_money),
          //                   title: Text("Halloo"),
          //                   subtitle: Text("data"),
          //                 ),
          //                 ListTile(
          //                   leading: Icon(Icons.attach_money),
          //                   title: Text("Halloo"),
          //                   subtitle: Text("data"),
          //                 ),
          //                 ListTile(
          //                   leading: Icon(Icons.attach_money),
          //                   title: Text("Halloo"),
          //                   subtitle: Text("data"),
          //                 ),
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    ));
  }
}
