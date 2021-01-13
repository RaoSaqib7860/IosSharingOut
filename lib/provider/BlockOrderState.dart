import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockOrderState extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var _listmain;
  get listmain => _listmain;
  setListMain(var list) {
    _listmain = list;
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }
}
