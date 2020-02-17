import 'package:flutter/material.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/auth/auth_provider.dart';
import 'package:yunikah/ui/component/animation.dart';
import 'package:yunikah/ui/menu_page.dart';

class AkunPage extends StatefulWidget {
  AkunPage({Key key}) : super(key: key);
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  List<AkunOption> _options;

  @override
  void initState() {
    super.initState();

    _options = [
      AkunOption(name: "Logout", icon: Icons.lock_open)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(AuthProvider.of(context).user.name),
              accountEmail: Text(AuthProvider.of(context).user.telp),
              currentAccountPicture: Icon(Icons.supervised_user_circle, size: 54,),
            ),
            ScrollConfiguration(
              behavior: ScrollBehavior(),
              child: ListView(
                shrinkWrap: true,
                children: ListTile.divideTiles(
                  context: context,
                  color: Colors.grey,
                  tiles: _options.map((option) {
                    return ListTile(
                      leading: Icon(option.icon),
                      title: Text(option.name),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: createLoadingAnimation(),
                            );
                          }
                        );

                        ApiService.instance.logout(AuthProvider.of(context).user).then((result) {

                          Navigator.of(context).pop();
                          if (result.data != null) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(10),
                                  content: Text('Tidak bisa logout'),
                                );
                              }
                            );
                            return;
                          }

                          Navigator.of(context).pushReplacementNamed(MenuPage.TAG);
                        });
                      },
                    );
                  }).toList()
                ).toList(),
              ),
            )
          ]
        ),
      ),
    );
  }
}

class AkunOption {
  String name;
  IconData icon;

  AkunOption({this.name, this.icon});
}