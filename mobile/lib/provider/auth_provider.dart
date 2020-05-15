import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';

class AuthProvider extends ValueNotifier<User> {
  AuthProvider(User value, [Future<User> futureValue]) : super(value) {
    futureValue?.then((nValue) => this.value ??= nValue);
  }

  bool get isAuthorized => value != null;
}