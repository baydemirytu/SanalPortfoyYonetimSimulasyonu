import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart' as mat;

class CustomShowDialog {
  static showDialog(BuildContext context, String message) {
    mat.showDialog(
        context: context,
        builder: (BuildContext context) {
          return mat.AlertDialog(
            content: Text(message),
          );
        });
  }
}
