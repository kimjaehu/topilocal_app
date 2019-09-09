import 'package:flutter/material.dart';
import 'package:topilocal_app/home_view.dart';
import 'package:topilocal_app/pages.dart';
import './pages.dart';
import './home_view.dart';

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomeState();
  }
}

class _MyHomeState extends State<MyHome> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(), SearchPage(), SavedPage(),AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topilocal'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            title: new Text('Saved'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_box),
            title: new Text('Account'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
