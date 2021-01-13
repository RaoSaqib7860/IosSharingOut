import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockWebScocketHome extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _listmain = [];
  List get listmain => _listmain;
  setListMain(List list) {
    _listmain = list;
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }
}
