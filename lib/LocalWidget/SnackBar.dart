import 'package:flutter/material.dart';

class SnackBars {
  static snackbar({GlobalKey<ScaffoldState> key, String text, Color c}) {
    key.currentState.showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 1),
      backgroundColor: c,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
