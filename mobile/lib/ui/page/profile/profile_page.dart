import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/network.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/ui/page.dart';

class ProfilePage extends StatelessWidget {
  Function onRestart = () {};

  ProfilePage({Key key, this.onRestart}) : super(key: key);

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              Routes.generatePage((_) => StatusPembelianPage(
                                initialIndex: 0
                              ))
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.send),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dikirim',
                                    style: Theme.of(context).textTheme.caption
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              Routes.generatePage((_) => StatusPembelianPage(
                                initialIndex: 1
                              ))
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.check_circle_outline),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dikonfirm',
                                    style: Theme.of(context).textTheme.caption
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              Routes.generatePage((_) => StatusPembelianPage(
                                initialIndex: 2
                              ))
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.sync),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Diproses',
                                    style: Theme.of(context).textTheme.caption
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              Routes.generatePage((_) => StatusPembelianPage(
                                initialIndex: 3
                              ))
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.done),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Selesai',
                                    style: Theme.of(context).textTheme.caption
                                  ),
                                )
                              ]
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.lock_open),
                  title: Text('Logout'),
                  onTap: () {
                    Helper.showLoading(context);

                    Network.instance.logout(user.token)
                    .then((status) {
                      Navigator.of(context).pop();

                      SharedPreferences.getInstance().then((prefs) {
                        prefs.clear();
                      });
                      
                      Provider.of<AuthProvider>(context, listen: false).value = null;

                      onRestart();
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