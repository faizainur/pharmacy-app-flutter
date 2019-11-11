import 'package:flutter/material.dart';


class RoundedContainer extends StatefulWidget {
  
final Widget rounded_child;

  RoundedContainer({Key key, this.rounded_child}) : super(key: key);

  @override
  _RoundedContainerState createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.only(top: 10),
        // height: 300.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                const Color(0xff1f83fe),
                const Color(0xff006bff),
                const Color(0xff006bff),
              ]),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0))),
          child: widget.rounded_child,
        ),
      );
  }
}