import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BlockReciverOrderPageHome extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  bool _status = true;
  bool get status => _status;
  setstatus(bool status) {
    _status = status;
    notifyListeners();
  }

  bool _timerstatus = false;
  bool get timerstatus => _timerstatus;
  settimerstatus(bool status) {
    _timerstatus = status;
    notifyListeners();
  }

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

  var _listofmainprogress;
  get listofmainprogress => _listofmainprogress;
  setListofmainprogress(var list) {
    _listofmainprogress = list;
    notifyListeners();
  }

  bool _ok = false;
  bool get ok => _ok;
  setOk(bool v) {
    _ok = true;
    notifyListeners();
  }

  String _errorText = '';
  String get errorText => _errorText;
  setErrorText(String text) {
    _errorText = text;
    notifyListeners();
  }
}
