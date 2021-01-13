import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../ItemRequestedReciver.dart';

class BlockItemRequestedReciver extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

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

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool l) {
    _loading = l;
    notifyListeners();
  }

  setListRating(index) {
    _searchList[index]['receiver_rated'] = true;
    notifyListeners();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;
  onRefresh() async {
    print('Now page is refresh');
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  onLoading() async {
    if (nextPageURL != '') {
      ApiUtilsClass.itemRequestedNextPageReciverData(
          ItemRequestedReciver.provider);
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
