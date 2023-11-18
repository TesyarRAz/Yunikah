import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yunikah/constant/routes.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/provider/auth_provider.dart';

class SplashLoginPage extends StatelessWidget {
  SplashLoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Anda belum login',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Text(
              'Silahkan login terlebih dahulu',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pushNamed(ROUTE_LOGIN);
              },
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Belum punya akun?',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                TextButton(
                  child: Text(
                    'Daftar',
                    style: Theme.of(context).textTheme.labelSmall?.apply(
                      color: Colors.blue
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ROUTE_REGISTER)
                    .then((_user) {
                      User user = _user as User;

                      if (user != null) {
                        SharedPreferences.getInstance().then((pref) {
                          pref.setString("username", user.username);
                          pref.setString("password", user.password!);
                          pref.setString("name", user.name);
                          pref.setString("token", user.token!);
                          
                          Provider.of<AuthProvider>(context).value = user;
                        });
                      }
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}