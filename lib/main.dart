import 'package:flutter/material.dart';
import 'package:pharmacy_app/history_page.dart';
import 'package:pharmacy_app/products_page.dart';
import 'home_page.dart';
import 'custom_navigation_drawer.dart';
import 'rounded_container_widget.dart';
import 'custom_app_bar.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: const Color(0xff1f83fe),
  ));
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
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    ProductsPage(
      scaffoldKey: _scaffoldKey,
    ),
    HistoryPage(),
    HistoryPage()
  ];

  void onItemTapped(int index) {
    setState(() {
      if (index == 2 || index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return _pages[index];
            }
          ),
        );
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Application Launched");
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        scafKey: _scaffoldKey,
        barHeight: 80,
      ),
      drawer: SafeArea(child: CustomNavigationDrawer()),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Products"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("History"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            title: Text("New"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: onItemTapped,
      ),
      body: RoundedContainer(
        roundedChild: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
