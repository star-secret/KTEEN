import 'package:flutter/material.dart';
import 'package:kteen_app/list_page.dart';
import 'package:kteen_app/map_page.dart';
import 'package:kteen_app/account_page.dart';


class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedndex = 0;
  List _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      ListPage(),
      MapPage(),
      AccountPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedndex]),
      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          onTap: onItemTapped,
          currentIndex: _selectedndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                title: Text('List')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Map')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                title: Text('Account')
            ),
          ]),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedndex = index;
    });
  }
}