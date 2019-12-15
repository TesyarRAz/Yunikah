import 'package:flutter/material.dart';

class Iklan {
  int id;
  String asset;

  ImageProvider get image => AssetImage('assets/images/$asset');

  Iklan({this.id, this.asset});

}