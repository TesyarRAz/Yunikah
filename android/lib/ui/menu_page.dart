import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/ui/akun/akun_page.dart';
import 'package:yunikah/ui/home/home_page.dart';

class MenuPage extends StatefulWidget {
  static const TAG = "menu";

  final User _authUser;

  MenuPage(this._authUser);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentTabIndex = 0;

  List<_HomeTabItem> _tabList;

  @override
  void initState() {
    super.initState();

    _tabList = [
      _HomeTabItem(text: 'Home', icon: Icons.home, builder: (user) => HomePage(user)),
      _HomeTabItem(text: 'Akun', icon: Icons.verified_user, builder: (user) => AkunPage(user)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTabIndex,
        items: _tabList.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(tab.icon),
            title: Text(tab.text),
          );
        }).toList(),
        onTap: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
      ),
      body: Container(
        child: _tabList[_currentTabIndex].builder(widget._authUser),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart, color: Colors.white,),
        onPressed: () {
          
        },
      ),
      // floatingActionButton: Material(
      //   color: Colors.orange,
      //   child: IconButton(
      //     icon: Icon(Icons.shopping_cart),
      //     onPressed: () {

      //     },
      //   ),
      // )
    );
  }
}

typedef _WidgetAuthCallback = Widget Function(User);

class _HomeTabItem {
  String text;
  IconData icon;
  _WidgetAuthCallback builder;

  _HomeTabItem({this.text, this.icon, this.builder});
}