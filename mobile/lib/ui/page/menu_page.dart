import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/ui/page.dart';

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
            child: PageStorage(
              bucket: _pageStorageBucket,
              child: _buildTabs()[index]
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _bottomNav(),
        )
      ],
    );
  }

  List<Widget> _buildTabs() {
    var auth = Provider.of<AuthProvider>(context);

    return [
      HomePage(
        key: PageStorageKey('home'),
      ),
      auth.isAuthorized ? KeranjangPage(
        key: PageStorageKey('keranjang'),
      ) : SplashLoginPage(
        key: PageStorageKey('splash_login'),
      ),
      auth.isAuthorized ? ProfilePage(
        key: PageStorageKey('profile'),
        onRestart: () => setState(() {}),
      ) : SplashLoginPage(
        key: PageStorageKey('splash_login'),
      )
    ];
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int nIndex) {
        if (index == nIndex) return;
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
          title: Text('Profile'),
          icon: Icon(Icons.account_box)
        )
      ],
    );
  }
}