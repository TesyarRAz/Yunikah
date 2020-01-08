import 'package:flutter/material.dart';
import 'package:yunikah/model/paket.dart';
import 'package:yunikah/ui/home/home_page.dart';

class PaketInfo extends StatelessWidget {
  final Paket paket;

  PaketInfo({Key key, @required this.paket}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Column(
        children: <Widget>[
          Hero(
            tag: paket.toString(),
            child: Image.network(paket.image.imageLink),
          )
        ],
      ),
    );
  }
}