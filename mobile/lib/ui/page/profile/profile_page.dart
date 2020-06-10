import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunikah/provider/auth_provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: false).value;
    return Scaffold(
      body: UserAccountsDrawerHeader(
        accountEmail: Text(user.telp),
        accountName: Text(user.name),
      ),
    );
  }
}