import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockGiverActiveRequest extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _searchList = [1];
  List get searchList => _searchList;
  setSeachList(List list) {
    _searchList = list;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }
}
