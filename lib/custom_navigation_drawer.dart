import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatefulWidget {
  @override
  _CustomNavigationDrawerState createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10)
      ),
      child: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text("My Shop"),
              ),
              ListTile(
                leading: Icon(
                  Icons.history,
                  color: Colors.black,
                ),
                title: Text("Transactions History"),
              ), 
              ListTile(
                leading: Icon(
                  Icons.show_chart,
                  color: Colors.black,
                ),
                title: Text("Overview"),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: Text("Settings"),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.black,
                ),
                title: Text("Log out"),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 4,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}
