import 'package:flutter/material.dart';

class SortBottomSheet extends StatefulWidget {
  List<String> listCategoriesName = [];
  List<bool> listCategoriesVal = [];

  SortBottomSheet(this.listCategoriesName, this.listCategoriesVal, {Key key})
      : super(key: key);
  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: <Widget>[
            Divider(
              color: Colors.grey,
              height: 3,
              endIndent: MediaQuery.of(context).size.width / 2.5,
              indent: MediaQuery.of(context).size.width / 2.5,
            ),
            Expanded(
              flex: 1,
              child: TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: 90),
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    text: "Categories",
                  ),
                  Tab(
                    text: "Sort by",
                  )
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TabBarView(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: widget.listCategoriesName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          value: widget.listCategoriesVal[index],
                          title: Text(widget.listCategoriesName[index]),
                          onChanged: (val) {
                            setState(() {
                              bool checkboxVal =
                                  widget.listCategoriesVal[index];
                              widget.listCategoriesVal[index] = !checkboxVal;
                            });
                          },
                        );
                      },
                    ),
                    Text("Sort"),
                  ],
                ),
              ),
            ),
            // Container(
            //   child: Padding(
            //     padding: EdgeInsets.all(10),
            // child: CloseButton(
            //     // color: Colors.lightBlue,
            //     // child: Text("Apply"),
            //     // onPressed: () {},
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
