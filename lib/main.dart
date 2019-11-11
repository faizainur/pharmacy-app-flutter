import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/history_transactions_page.dart';
import 'package:pharmacy_app/products_page.dart';
import 'home_page.dart';
import 'custom_navigation_drawer.dart';
import 'rounded_container_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(
        title: 'Pharmacy App',
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    ProductsPage(),
    HistoryTransactionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SafeArea(
          child: Container(
            // color: const Color(0xff006bff),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xff1f83fe),
                    const Color(0xff006bff),
                    const Color(0xff006bff),
                  ]),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 25, top: 10, bottom: 8),
              leading: CircleAvatar(
                radius: 25,
              ),
              // Icon(
              //   Icons.menu,
              //   size: 30,
              //   color: Colors.white,
              // ),
              title: Row(
                children: <Widget>[
                  // Text(
                  //   "Hello, ",
                  //   style: TextStyle(
                  //       color: Colors.white, fontSize: 20, letterSpacing: 2),
                  // ),
                  Text(
                    "Faiz Ainur Rofiq",
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              subtitle: Text(
                "Owner",
                style: TextStyle(
                  color: Colors.white70,
                  letterSpacing: 1.7,
                ),
              ),
              onTap: () {
                setState(() {
                  _scaffoldKey.currentState.openDrawer();
                });
              },
            ),
          ),
        ),
      ),
      drawer: CustomNavigationDrawer(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.list),
              title: Text('Products'),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Sell'),
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.black),
        ],
      ),
      body: RoundedContainer(
        rounded_child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
