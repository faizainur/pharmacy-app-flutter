import 'package:flutter/material.dart';

import 'models/product.dart';

class ItemTile extends StatelessWidget {
  final Product product;
  final int qty;

  ItemTile(this.product, this.qty);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Text(
                      product.productName,
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Rp. " +
                          product.price.toString() +
                          " x " +
                          qty.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Text(
                      "",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Rp. " + (product.price * qty).toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
