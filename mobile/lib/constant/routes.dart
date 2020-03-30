import 'package:flutter/material.dart';
import 'package:yunikah/ui/menu_page.dart';
import 'package:yunikah/ui/splash_page.dart';

const ROUTE_SPLASH = "/";
const ROUTE_HOME = "/home";

class Routes {
  Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_HOME: return _generatePage((_) => MenuPage());
      case ROUTE_SPLASH: return _generatePage((_) => SplashPage());
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

  static const SPLASH_PAGE = "/";
  static const HOME_PAGE = "/home";
}