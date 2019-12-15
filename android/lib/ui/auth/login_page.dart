import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/auth/register_page.dart';
import 'package:yunikah/ui/menu_page.dart';

class LoginPage extends StatefulWidget {
  static const TAG = 'user.login';

  LoginPage({ Key key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController, _passwordController;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ScrollConfiguration(
            behavior: ScrollBehavior(),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Icon(Icons.supervised_user_circle, size: 100,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildUsername(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: _buildPassword(),
                ),
                _buildButtonLogin(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    child: Text('Lupa Password', style: TextStyle(color: Colors.black54),),
                    onTap: _validateForgotPassword,
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text('Daftar', style: TextStyle(color: Colors.white,)),
                    onPressed: _validateDaftar,
                  ),
                )
              ],
            ),
          )
        )
      ),
    );
  }

  Widget _buildUsername() =>
    TextFormField(
      controller: _usernameController,
      autofocus: false,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          decoration: TextDecoration.none
        ),
        labelText: 'Username',
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(Icons.verified_user),
      ),
      keyboardType: TextInputType.text,
    );

  Widget _buildPassword() =>
    TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: Icon(Icons.lock)
      ),
    );

  Widget _buildButtonLogin() =>
    Material(
      borderRadius: BorderRadius.circular(10),
      shadowColor: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: 200,
        height: 40,
        color: Theme.of(context).primaryColor,
        hoverColor: Theme.of(context).primaryColor,
        colorBrightness: Brightness.light,
        child: Text('Masuk', style: TextStyle(color: Colors.white),),
        onPressed: _validateLogin,
      ),
    );

    void _validateLogin() {
      String username = _usernameController.text;
      String password = _passwordController.text;

      if (username.isEmpty || password.isEmpty) return;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Loading...'),
                  )
                ],
              ),
            )
          );
        }
      );

      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pop();
        
        ApiService().login(User(username, password)).then((user) {
          if (user == null) {
            showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Username atau password salah!'),
                  ),
                  insetAnimationCurve: Curves.fastOutSlowIn,
                  insetAnimationDuration: Duration(seconds: 2),
                );
              }
            ).then((_) {
              setState(() {
                _usernameController.text = '';
                _passwordController.text = '';
              });
            });
            
            return;
          }

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MenuPage(user)
            )
          );
        });
      });
    }

    void _validateForgotPassword() {
      
    }

    void _validateDaftar() {
      Navigator.of(context).push(
        MaterialPageRoute(
          maintainState: true,
          fullscreenDialog: true,
          builder: (_) => RegisterPage()
        )
      );
    }
}