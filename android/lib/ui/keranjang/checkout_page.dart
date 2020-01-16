import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _controllerAlamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildAlamat
          ],
        ),
      ),
    );
  }

  Widget get _buildAlamat => TextFormField(
    controller: _controllerAlamat,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      hintText: "Alamat"
    ),
  );
}