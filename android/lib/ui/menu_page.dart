import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/ui/akun/akun_page.dart';
import 'package:yunikah/ui/auth/auth_provider.dart';
import 'package:yunikah/ui/auth/login_page.dart';
import 'package:yunikah/ui/belanja/belanja_page.dart';
import 'package:yunikah/ui/home/home_page.dart';
import 'package:yunikah/ui/keranjang/keranjang_page.dart';

class MenuPage extends StatefulWidget {
  static const TAG = "menu";

  final User user;

  MenuPage({Key key, this.user}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _currentTabIndex = 0;

  List<_HomeTabItem> _tabList;

  final PageStorageBucket _pageBucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _tabList = [
      _HomeTabItem(
        text: 'Home', 
        icon: Icons.home, 
        body: HomePage(key: PageStorageKey('Home'),)
      ),
      _HomeTabItem(
        text: 'Belanja', 
        icon: Icons.add_shopping_cart, 
        body: BelanjaPage(key: PageStorageKey('Belanja'),)
      ),
    ];


    if (widget.user != null) {
      _tabList.addAll([
          _HomeTabItem(
          text: 'Keranjang', 
          icon: Icons.shopping_cart, 
          body: KeranjangPage(key: PageStorageKey('Keranjang'))
        ),
        _HomeTabItem(
          text: 'Akun', 
          icon: Icons.account_box, 
          body: AkunPage(key: PageStorageKey('Akun'))
        ),
      ]);
    } else {
      _tabList.addAll([
          _HomeTabItem(
            text: 'Akun',
            icon: Icons.account_box,
            body: Center(
              child: FlatButton(
                child: Text('Login Here'),
                onPressed: () => Navigator.of(context).pushNamed(LoginPage.TAG),
              ),
            )
          )
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      user: widget.user,
      child: Scaffold(
        key: _scaffoldKey,
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
        body: PageStorage(
          bucket: _pageBucket,
          child: _tabList[_currentTabIndex].body
        ),
      ),
    );
  }
}

class _HomeTabItem {
  String text;
  IconData icon;
  Widget body;

  _HomeTabItem({this.text, this.icon, this.body});
}