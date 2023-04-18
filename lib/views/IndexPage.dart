import 'package:flutter/material.dart';

import '../component/RightDrawer.dart';
import 'tabs/SettingPage.dart';
import 'tabs/HomePage.dart';

class IndexPage extends StatefulWidget {
  static const routeName = '/';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  IndexPage({Key? key}) : super(key: key);

  @override
  _IndexPage createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> {
  int _selectedIndex = 0;
  String title = "JPK";

  static List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SettingPage(),
  ];

  List<String> widgetTitles = [HomePage.title, SettingPage.title];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前选中的页面组件
    final selectedWidget = _widgetOptions[_selectedIndex];

    return Scaffold(
      key: IndexPage.scaffoldKey,
      appBar: AppBar(
        title: Text(widgetTitles[_selectedIndex]),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.list, color: Colors.white), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: RightDrawer(),
      //抽屉
      body: selectedWidget,
      floatingActionButton: FloatingActionButton(
        //悬浮按钮
        onPressed: () {},
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
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
