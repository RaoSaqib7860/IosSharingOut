import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../NearBySeachPage.dart';

class BlockNearbySearch extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController get nameCon => _nameCon;
  bool _anim = false;
  bool get anim => _anim;
  setAnim(bool v) {
    _anim = v;
    notifyListeners();
  }

  int _km;
  int get km => _km;
  setKm(int val) {
    _km = val;
    notifyListeners();
  }

  List _searchList = [];
  List get searchList => _searchList;
  setSeachList(List list) {
    _searchList = list;
    notifyListeners();
  }

  addlistData(data) {
    _searchList.add(data);
    notifyListeners();
  }

  bool _loadinglt = false;
  bool get loadinglt => _loadinglt;
  setloadinglt(bool l) {
    _loadinglt = l;
    notifyListeners();
  }

  bool _loading = true;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }

  String _loadingtext = 'Please Select Range';
  String get loadingtext => _loadingtext;
  setloadingtext(String l) {
    _loadingtext = l;
    notifyListeners();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;
  onRefresh() async {
    // monitor network fetch
    print('Now page is refresh');
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  onLoading() async {
    if (nextPageURL != '') {
      ApiUtilsClass.searchNextFoodCallings(NearBySearchPage.latlng,
          NearBySearchPage.provider, _refreshController);
    } else {
      _refreshController.loadComplete();
      SnackBars.snackbar(
          c: Colors.red, key: _scaffoldKey, text: 'No more record.');
    }
  }

  String _nextPageURL = '';
  String get nextPageURL => _nextPageURL;
  setnextPageURL(String url) {
    print('next url =$url');
    _nextPageURL = url;
    notifyListeners();
  }
}
