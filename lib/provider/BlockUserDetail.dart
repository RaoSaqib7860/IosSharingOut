import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BLockUserDetail extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var _maindata;
  get maindata => _maindata;
  setMainData(var data) {
    _maindata = data;
  }

  bool _loading = false;
  bool get loding => _loading;
  setLoadiing(bool val) {
    _loading = val;
    notifyListeners();
  }
}
