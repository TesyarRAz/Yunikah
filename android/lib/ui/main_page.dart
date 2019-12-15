import 'package:flutter/material.dart';
import 'package:yunikah/ui/auth/register_page.dart';
import 'package:yunikah/ui/auth/login_page.dart';
import 'package:yunikah/ui/splash_page.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      routes: <String, WidgetBuilder>{
        LoginPage.TAG: (_) => LoginPage(),
        RegisterPage.TAG: (_) => RegisterPage(),
      },
      home: SplashPage(),
    );
  }
}