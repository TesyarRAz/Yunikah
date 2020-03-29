import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/provider/auth_provider.dart';
import 'package:yunikah/ui/login/login_page.dart';
import 'package:yunikah/ui/register/register_page.dart';

class SplashLoginPage extends StatelessWidget {
  SplashLoginPage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Anda belum login',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
            Text(
              'Silahkan login terlebih dahulu',
              style: Theme.of(context).textTheme.subtitle,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => LoginPage()
                  )
                )
                .then((user) {
                  if (user != null) {
                    Provider.of<AuthProvider>(context).value = user;
                  }
                });
              },
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Belum punya akun?',
                  style: Theme.of(context).textTheme.overline,
                ),
                GestureDetector(
                  child: Text(
                    'Daftar',
                    style: Theme.of(context).textTheme.overline.apply(
                      color: Colors.blue
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RegisterPage()
                      )
                    )
                    .then((user) {
                      if (user != null) {
                        Provider.of<AuthProvider>(context).value = user;
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