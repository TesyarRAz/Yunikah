import 'package:flutter/material.dart';
import 'package:yunikah/model/user.dart';
import 'package:yunikah/network/api_service.dart';
import 'package:yunikah/ui/auth/register_page.dart';
import 'package:yunikah/ui/component/animation.dart';
import 'package:yunikah/ui/menu_page.dart';

class LoginPage extends StatefulWidget {
  static const TAG = 'user.login';

  final Function(User) callbackUser;

  LoginPage({ this.callbackUser});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController, _passwordController;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Yunikah',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 32,
                        fontFamily: 'Times New Roman'
                    )
                  ),
                ),
                Divider(),
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
            )
          ),
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
            child: createLoadingAnimation()
          );
        }
      );

      ApiService.instance.login(username, password).then((result) {
        Navigator.of(context).pop();
        if (result.data == null) {
          ApiError _apiError = result as ApiError;
          showDialog(
            context: context,
            builder: (_) {
              return Dialog(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(_apiError.message),
                ),
                insetAnimationCurve: Curves.fastOutSlowIn,
                insetAnimationDuration: Duration(seconds: 2),
              );
            }
          );
          
          return;
        }

        // widget.callbackUser(result.data);

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => MenuPage(
            user: result.data,
          )
        ));
      }).then((_) {
          setState(() {
            _usernameController.text = '';
            _passwordController.text = '';
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