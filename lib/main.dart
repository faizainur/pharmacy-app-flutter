import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

int _page = 0;
GlobalKey _bottomNavigationKey = GlobalKey();

void main() {
  runApp(MyApp());
  // WidgetsBinding.instance
  //         .addPostFrameCallback((_) => (){
  //           final CurvedNavigationBarState navbarState =
  //               _bottomNavigationKey.currentState;
  //           navbarState.setPage(3);
  //         },);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Pharmacy App',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color bgColor = const Color(0xffe1eeff);

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 45,
                  color: Colors.white,
                ),
                title: Text(
                  "Faiz Ainur Rofiq",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),                                                                                                                                                                                                                                                           
      ),
      
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
         inactiveColor: Colors.black
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.list),
         title: Text('Products'),
         activeColor: Colors.blueAccent,
         inactiveColor: Colors.black
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.history),
         title: Text('Transactions'),
         activeColor: Colors.blueAccent,
         inactiveColor: Colors.black
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.shopping_cart),
         title: Text('Sell'),
         activeColor: Colors.blueAccent,
         inactiveColor: Colors.black
     ),
   ],
),

      body: Container(
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
            child: Center(
              child: Text("Hi modal sheet"),
            )),
      ),
    );
  }
}
