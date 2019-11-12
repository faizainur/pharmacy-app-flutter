import 'package:flutter/material.dart';


class RoundedContainer extends StatefulWidget {
  
final Widget roundedChild;

  RoundedContainer({Key key, this.roundedChild}) : super(key: key);

  @override
  _RoundedContainerState createState() => _RoundedContainerState();
}

class _RoundedContainerState extends State<RoundedContainer> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff1f83fe),
        // padding: EdgeInsets.only(top: 10),
        // height: 300.0,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topLeft,
        //       end: Alignment.topRight,
        //       colors: [
        //         const Color(0xff1f83fe),
        //         const Color(0xff006bff),
        //         const Color(0xff006bff),
        //       ]),
        // ),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xfff6f8fa),
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0))),
          child: widget.roundedChild,
        ),
      );
  }
}