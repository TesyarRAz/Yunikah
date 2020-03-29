import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';

class AuthProvider extends ValueNotifier<User> {
  AuthProvider(User value) : super(value);

  bool get isAuthorized => value != null;
}