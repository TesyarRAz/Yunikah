import 'package:flutter/material.dart';
import 'package:yunikah/ui/page.dart';

const ROUTE_SPLASH = "/";
const ROUTE_HOME = "/home";
const ROUTE_REGISTER = "/register";
const ROUTE_LOGIN = "/login";
const ROUTE_SEARCH = "/search";

class Routes {
  Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ROUTE_HOME: return generatePage((_) => MenuPage());
      case ROUTE_SPLASH: return MaterialPageRoute(builder: (_) => SplashPage());
      case ROUTE_REGISTER: return generatePage((_) => RegisterPage());
      case ROUTE_LOGIN: return generatePage((_) => LoginPage());
      case ROUTE_SEARCH: return generatePage((_) => SearchPage());
      default: return generatePage((_) => Center(
        child: Text('Route Not Found'),
      ));
    }
  }

  static Route generatePage(WidgetBuilder builder) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, _) => builder(context),
      transitionsBuilder: (context, animation, animationExit, _) => FadeTransition(
        opacity: animation,
        child: builder(context),
      ),
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}