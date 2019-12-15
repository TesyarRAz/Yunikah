import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/ui/auth/login_page.dart';

class AkunPage extends StatefulWidget {
  static const TAG = 'akun';

  final User authUser;

  AkunPage(this.authUser);

  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: false,
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                title: TextStyle(color: Colors.white)
              )
            ),
            child: UserAccountsDrawerHeader(
              accountName: Text(widget.authUser.name, style: Theme.of(context).textTheme.title),
              accountEmail: Text('${widget.authUser.name}@gmail.com', style: Theme.of(context).textTheme.title),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.supervised_user_circle, size: 70,),
              )
            ),
          )
        ]..addAll(
          _options.map((option) {
            return ListTile(
              title: Text(option.text),
              leading: Icon(option.icon),
              trailing: Icon(option.info),
              onTap: () => option.action(context),
            );
          }).toList()
        ),
      ),
    );
  }
}

List<AkunOption> _options = [
  AkunOption(text: 'Setting', icon: Icons.settings, action: (context) {}),
  AkunOption(text: 'Logout', icon: Icons.lock_open, action: (context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Yakin Ingin Keluar ?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ya'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(LoginPage.TAG);
            },
          ),
          FlatButton(
            child: Text('Tidak'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]
      )
    );
  }),
];

class AkunOption {
  String text;
  IconData icon;
  IconData info;
  Function(BuildContext) action;

  AkunOption({this.text, this.icon, this.info = Icons.arrow_forward, this.action });
}