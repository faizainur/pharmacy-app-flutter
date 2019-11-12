import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/history_transactions_page.dart';
import 'package:pharmacy_app/products_page.dart';
import 'home_page.dart';
import 'custom_navigation_drawer.dart';
import 'rounded_container_widget.dart';
import 'custom_app_bar.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: const Color(0xff1f83fe),));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

      ),
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
      appBar: CustomAppBar(
        scafKey: _scaffoldKey,
        barHeight: 80,
      ),
      drawer: SafeArea(child: CustomNavigationDrawer()),
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
        roundedChild: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
