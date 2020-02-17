import 'package:flutter/material.dart';
import 'package:yunikah/ui/auth/login_page.dart';
import 'package:yunikah/ui/component/animation.dart';

class RegisterPage extends StatefulWidget {
  static const TAG = 'user.register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _username, _password, _confirmPassword, _nama;

  @override
  void initState() {
    super.initState();

    _username = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _nama = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Register '),
                      Text('Yunikah', style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32
                      ),)
                    ],
                  ),
                ),
                _buildUsername(),
                _buildPassword(),
                _buildConfirmPassword(),
                _buildName(),
                _buildSubmit()
              ],
            ),
          )
        ),
      )
    );
  }

  Widget _buildUsername() => 
    Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _username,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: 'Username',
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          )
        ],
      ),
    );

    Widget _buildPassword() =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _password,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: 'Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          ),
        ),
      );
    Widget _buildConfirmPassword() =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _confirmPassword,
          autofocus: false,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: 'Konfirmasi Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          ),
        ),
      );
    Widget _buildName() =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          controller: _nama,
          autofocus: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: 'Nama',
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      );
    Widget _buildSubmit() =>
      Material(
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 15),
          autofocus: false,
          color: Theme.of(context).primaryColor,
          child: Text('Daftar Sekarang!', style: TextStyle(color: Colors.white),),
          onPressed: _validateRegister,
        ),
      );

    void _validateRegister() {
      if (_username.text.isEmpty || _password.text.isEmpty || _confirmPassword.text.isEmpty || _nama.text.isEmpty) return;

      if (_password.text != _confirmPassword.text) {
        showDialog(
          context: context,
          builder: (_) =>
            Dialog(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text('Username dan password konfirmasi tidak sama!'),
              ),
            )
        );

        return;
      }

      showDialog(
        context: context,
        builder: (_) =>
          Dialog(
            child: createLoadingAnimation()
          )
      );
      
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();

        showDialog(
          context: context,
          builder: (_) =>
            Dialog(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text('Berhasi Daftar'),
              ),
            )
        ).whenComplete(() {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(LoginPage.TAG);
        });
      });
    }
}