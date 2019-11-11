import 'package:flutter/material.dart';

class HistoryTransactionsPage extends StatefulWidget {
  @override
  _HistoryTransactionsPageState createState() => _HistoryTransactionsPageState();
}

class _HistoryTransactionsPageState extends State<HistoryTransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0))),
      child: Center(
        child: Text("transactions pages"),
      ),
    );
  }
}