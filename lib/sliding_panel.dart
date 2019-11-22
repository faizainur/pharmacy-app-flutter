import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SlidingPanel extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffKey = GlobalKey<ScaffoldState>();

  SlidingPanel({Key key, this.scaffKey}) : super(key: key);
  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
