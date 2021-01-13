import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlockWebScocket extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _senderCon = TextEditingController();
  TextEditingController get senderCon => _senderCon;

  List _listmain = [];
  List get listmain => _listmain;
  setListMain(List list) {
    _listmain = list;
  }

  addListListData(Map data) {
    if (_listmain == null || _listmain.length == 0) {
      _listmain = [data];
    } else {
      _listmain.insert(0, data);
    }
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }

  bool _loadingImage = false;
  bool get loadingImage => _loadingImage;
  setloadingImage(bool l) {
    _loadingImage = l;
    notifyListeners();
  }

  var _listuser;
  get listuser => _listuser;
  setlistuser(var list) {
    _listuser = list;
    notifyListeners();
  }

  bool _streams = false;
  bool get streams => _streams;
  setstreams(bool l) {
    _streams = l;
    notifyListeners();
  }
}
