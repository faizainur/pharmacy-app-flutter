import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: BackButton(color: Colors.grey[800],),
        title: Text(
          "Transaction History",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: Container(
        child: Center(
          child: Text("transactions pages"),
        ),
      ),
    );
  }
}
