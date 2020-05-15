import 'package:flutter/material.dart';
import 'package:yunikah/helper.dart';
import 'package:yunikah/network.dart';

class LoginPage extends StatefulWidget {
  final _formLoginState = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  TextEditingController _textUsername;
  TextEditingController _textPassword;

  @override
  void initState() {
    super.initState();

    _textUsername = TextEditingController();
    _textPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: widget._formLoginState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Yunikah', 
                style: Theme.of(context).textTheme.display2.apply(
                  color: Theme.of(context).primaryColor
                ),
              ),
              TextFormField(
                controller: _textUsername,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _textPassword,
                obscureText: !showPassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() {
                      showPassword = !showPassword;
                    }),
                  )
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Lupa Password'),
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Masuk'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      child: Helper.createLoading(),
                    ),
                    barrierDismissible: false
                  );

                  Network.instance.login(_textUsername.text, _textPassword.text)
                  .then((user) {
                    Navigator.of(context).pop();
                    if (user != null) {
                      Navigator.of(context).pop(user);
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}