import 'package:flutter/material.dart';
import 'models/product.dart';
import 'package:avatar_letter/avatar_letter.dart';
import 'package:random_color/random_color.dart';

class ProductCard extends StatefulWidget {
  String imageUrl;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: SizedBox(
          height: 80,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: AvatarLetter(
                      size: 50,
                      backgroundColor: RandomColor().randomColor(
                          colorBrightness: ColorBrightness.light),
                      textColor: Colors.black,
                      fontSize: 26,
                      upperCase: true,
                      numberLetters: 2,
                      letterType: LetterType.Rectangle,
                      text: 'Paracetamol Test',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Paracetamol",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Rp. 10,000")
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Stock", style: TextStyle(fontSize: 16)),
                      Text(
                        "5",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
