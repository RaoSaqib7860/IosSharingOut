import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocliSpin {
  static Widget spinKit({Color c}) {
    return SpinKitFadingCircle(
      color:c,
      size: 25.0,
    );
  }
}
