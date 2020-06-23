import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).value;
    return Scaffold(
      body: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(user.phone),
            accountName: Text(user.name)
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.lock_open),
                  title: Text('Logout'),
                  onTap: () {
                    showDialog(context: context, builder: (_) => Dialog(
                      child: Helper.createLoading(),
                    ));

                    Network.instance.logout(user.token)
                    .then((status) {
                      Navigator.of(context).pop();

                      SharedPreferences.getInstance().then((prefs) {
                        prefs.clear();
                      });
                      
                      Provider.of<AuthProvider>(context).value = null;
                    });
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}