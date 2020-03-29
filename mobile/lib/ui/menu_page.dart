import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/ui/home/home_page.dart';
import 'package:yunikah/ui/keranjang/keranjang_page.dart';
import 'package:yunikah/ui/login/splash_login_page.dart';
import 'package:yunikah/ui/profile/profile_page.dart';

class MenuPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  PageStorageBucket _pageStorageBucket;
  int index = 0;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays(
      [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom
      ]
    );

    _pageStorageBucket = PageStorageBucket();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 40),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            child: _buildTabs()[index],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _bottomNav(),
        )
      ],
    );
  }

  List<Widget> _buildTabs() => [
    PageStorage(
      key: PageStorageKey("home"),
      bucket: _pageStorageBucket,
      child: HomePage()
    ),
    Provider.of<AuthProvider>(context).isAuthorized ? PageStorage(
      key: PageStorageKey("keranjang"),
      bucket: _pageStorageBucket,
      child: KeranjangPage(),
    ) : PageStorage(
      key: PageStorageKey("login"),
      bucket: _pageStorageBucket,
      child: SplashLoginPage(),
    ),
    Provider.of<AuthProvider>(context).isAuthorized ? PageStorage(
      key: PageStorageKey("profile"),
      bucket: _pageStorageBucket,
      child: ProfilePage(),
    ) : PageStorage(
      key: PageStorageKey("login"),
      bucket: _pageStorageBucket,
      child: SplashLoginPage(),
    )
  ];

  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int nIndex) {
        setState(() {
          index = nIndex;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('Home'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('Keranjang'),
          icon: Icon(Icons.shopping_cart)
        ),
        BottomNavigationBarItem(
          title: Text(Provider.of<AuthProvider>(context, listen: false).isAuthorized ? 'Profile' : 'Login'),
          icon: Icon(Icons.account_box)
        )
      ],
    );
  }
}