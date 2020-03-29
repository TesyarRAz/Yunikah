import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final _formRegisterState = GlobalKey<FormState>();

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _textUsername, _textPassword, _textNama, _textAlamat;

  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    _textUsername = TextEditingController();
    _textPassword = TextEditingController();
    _textNama = TextEditingController();
    _textAlamat = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: widget._formRegisterState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Register'),
                  Text(
                    'Yunikah',
                    style: Theme.of(context).textTheme.title.apply(
                      fontSizeDelta: 15,
                      color: Theme.of(context).primaryColor
                    ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              TextFormField(
                controller: _textNama,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nama"
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _textUsername,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username"
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _textPassword,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () => setState(() {
                      showPassword = !showPassword;
                    }),
                  )
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _textAlamat,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat'
                ),
              ),
              SizedBox(height: 40,),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Daftar'),
                onPressed: () {

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}