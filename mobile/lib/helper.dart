import 'package:flutter/material.dart';
import 'package:yunikah/ui/component/component.dart';

class Helper {
  static showLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
