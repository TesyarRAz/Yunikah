import 'package:flutter/material.dart';

class Helper {
  static Widget createLoading() => Padding(
    padding: const EdgeInsets.all(18.0),
    child: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 20,),
        Text('Sedang Meloading...')
      ],
    ),
  );
}