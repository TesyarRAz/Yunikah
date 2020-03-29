import 'package:flutter/material.dart';
import 'package:yunikah/ui/login/login_page.dart';
import 'package:yunikah/ui/menu_page.dart';
import 'package:yunikah/ui/register/register_page.dart';
import 'package:yunikah/ui/splash_page.dart';

const ROUTE_SPLASH = "/";
const ROUTE_HOME = "/home";
const ROUTE_REGISTER = "/register";
const ROUTE_LOGIN = "/login";

class Routes {
  Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_HOME: return _generatePage((_) => MenuPage());
      case ROUTE_SPLASH: return _generatePage((_) => SplashPage());
      case ROUTE_REGISTER: return _generatePage((_) => RegisterPage());
      case ROUTE_LOGIN: return _generatePage((_) => LoginPage());
      default: return _generatePage((_) => Center(
        child: Text('Route Not Found'),
      ));
    }
  }

  static Route _generatePage(WidgetBuilder builder) {
    return MaterialPageRoute(
      builder: builder
    );
  }
}