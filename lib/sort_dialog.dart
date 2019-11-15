import 'package:flutter/material.dart';

class SortDialog extends StatefulWidget {
  SortDialog(
      {Key key,
      this.listCategoriesName,
      this.listCategoriesVal,
      this.listChipWidget,
      this.listChipLabel,
      this.parentKey})
      : super(key: key);
  List<Widget> listWidgets = [];
  GlobalKey<ScaffoldState> parentKey;
  List<Widget> listChipWidget = List<Widget>();
  List<String> listChipLabel = List<String>();

  List<String> listCategoriesName = [];
  List<bool> listCategoriesVal = [];
  @override
  _SortDialogState createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // widget.listCategories.forEach((k, v) => print("$k $v"));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listWidgets.isNotEmpty) {
      widget.listWidgets.clear();
    }
    widget.listCategoriesName.forEach(
      (v) {
        int index = widget.listCategoriesName.indexOf(v);
        bool checkboxVal = widget.listCategoriesVal[index];
        widget.listWidgets.add(
          CheckboxListTile(
            value: checkboxVal,
            title: Text(v),
            onChanged: (value) {
              setState(
                () {
                  widget.listCategoriesVal[index] = !checkboxVal;
                },
              );
            },
          ),
        );
      },
    );
    widget.listWidgets.add(RaisedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Text("Exit"),
      ),
    ));
    return SimpleDialog(
      title: Text("Sort Data"),
      children: widget.listWidgets,
    );
  }
}
