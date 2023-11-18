import 'package:flutter/material.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/network.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  late TextEditingController _textUsername, _textPassword, _textNama, _textPhone, _textEmail;
  
  bool _showPassword = false;
  int _pageIndex = 1;

  @override
  void initState() {
    super.initState();

    _textUsername = TextEditingController();
    _textPassword = TextEditingController();
    _textNama = TextEditingController();
    _textPhone = TextEditingController();
    _textEmail = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Register'),
                Text(
                  'Yunikah',
                  style: Theme.of(context).textTheme.titleLarge?.apply(
                    fontSizeDelta: 15,
                    color: Theme.of(context).primaryColor
                  ),
                )
              ],
            ),
            SizedBox(height: 30,),
            
            AnimatedContainer(
              duration: Duration(seconds: 2),
              child: _pageIndex == 1 ? _buildPageOne() : _buildPageTwo(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageOne() => Column(
    children: <Widget>[
      TextFormField(
        controller: _textNama,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Nama"
        ),
      ),
      SizedBox(height: 20,),
      TextFormField(
        controller: _textPhone,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'No.Telp'
        ),
      ),
      SizedBox(height: 20,),
      TextFormField(
        controller: _textEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email"
        ),
      ),
      SizedBox(height: 40,),
      MaterialButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text('Berikutnya'),
        onPressed: () {
          setState(() {
            _pageIndex = 2;
          });
        },
      )
    ],
  );

  Widget _buildPageTwo() => Column(
    children: <Widget>[
      TextFormField(
        controller: _textUsername,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Username"
        ),
      ),
      SizedBox(height: 20,),
      TextFormField(
        controller: _textPassword,
        obscureText: !_showPassword,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() {
              _showPassword = !_showPassword;
            }),
          )
        ),
      ),
      SizedBox(height: 40,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MaterialButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('Sebelumnya'),
            onPressed: () {
              setState(() {
                _pageIndex = 1;
              });
            },
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('Daftar'),
            onPressed: () {
              var username = _textUsername.text;
              var password = _textPassword.text;
              var name = _textNama.text;
              var phone = _textPhone.text;
              var email = _textEmail.text;

              if (username.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty || email.isEmpty) return;

              var user = User(
                name: name,
                phone: phone,
                username: username,
                password: password,
                email: email
              );

              Helper.showLoading(context);

              Network.instance.register(user)
              .then((result) {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: Text(result?['message'] ?? "Inputan tidak benar"),
                  ),
                )
                .then((_) {
                  if (result?['status'] == 200)
                    Navigator.of(context).pop();
                });
              });
            },
          )
        ],
      )
    ],
  );
}