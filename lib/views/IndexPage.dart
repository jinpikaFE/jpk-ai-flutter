import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tabs/DetailPage.dart';
import 'tabs/HomePage.dart';

class IndexPage extends StatefulWidget {
  static const routeName = '/';

  IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DetailPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: _widgetOptions[_selectedIndex],
      floatingActionButton: FloatingActionButton( //悬浮按钮
        onPressed: () { },
        child: Icon(Icons.add),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Detail',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
