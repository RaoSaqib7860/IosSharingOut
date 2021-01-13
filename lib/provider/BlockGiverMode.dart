import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockGiverMode extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var _listmain;
  get listmain => _listmain;
  setListMain(var list) {
    _listmain = list;
  }

  var _listofmainprogress;
  get listofmainprogress => _listofmainprogress;
  setListofmainprogress(var list) {
    _listofmainprogress = list;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }

  String _deliverd = 'Deliver food';
  String get deliverd => _deliverd;
  setDelivered(String deliverd) {
    _deliverd = deliverd;
    notifyListeners();
  }
}
