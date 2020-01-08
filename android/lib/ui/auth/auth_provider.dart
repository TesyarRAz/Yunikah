import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';

class AuthProvider extends InheritedWidget {
  final User user;

  AuthProvider({
    Key key,
    Widget child,
    @required this.user
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AuthProvider oldWidget) {
    return oldWidget.user != user;
  }

  static AuthProvider of(BuildContext context) => context.inheritFromWidgetOfExactType(AuthProvider);
}