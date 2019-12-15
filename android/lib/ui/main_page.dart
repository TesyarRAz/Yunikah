import 'package:flutter/material.dart';
import 'package:yunikah/ui/auth/register_page.dart';
import 'package:yunikah/ui/auth/login_page.dart';
import 'package:yunikah/ui/splash_page.dart';

var routes = <String, WidgetBuilder>{
  LoginPage.TAG: (_) => LoginPage(
    callbackUser: (user) {
    
    },
  ),
  RegisterPage.TAG: (_) => RegisterPage(),
};

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light
      ),
      themeMode: ThemeMode.dark,
      title: 'Yunikah',
      routes: routes,
      home: SplashPage(),
    );
  }
}