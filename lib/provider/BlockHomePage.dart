import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/SharedPrefence/SharedPreference.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';

class BlockHomePage extends ChangeNotifier {
  BlockHomePage({BlockHomePage provider});
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List _activeList = [];
  List get activeList => _activeList;
  setactiveMainLis(Map m) {
    _activeList.add(m);
    notifyListeners();
  }

  List _inActiveList = [];
  List get inActiveList => _inActiveList;
  setinActiveList(Map m) {
    _inActiveList.add(m);
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setloading(bool val) {
    _loading = val;
    notifyListeners();
  }

  var _stateData;
  get stateData => _stateData;
  setStateData(var data) async {
    _stateData = data;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String chek = prefs.getString('giver_active');
    if (chek == null) {
      SharedPreferenceClass.addgiverActive('${_stateData['giver_active']}');
      SharedPreferenceClass.addgiverCompleted(
          '${_stateData['giver_completed']}');
      SharedPreferenceClass.addreciverActive(
          '${_stateData['receiver_active']}');
      SharedPreferenceClass.addreciverCompleted(
          '${_stateData['receiver_completed']}');
    }
    setGiverActive(_stateData['giver_active']);
    setgiverCompleted(_stateData['giver_completed']);
    setreciveractive(_stateData['receiver_active']);
    setreciverRequested(_stateData['receiver_completed']);
  }

  int _giveractive = 0;
  int get giveractive => _giveractive;
  setGiverActive(int v) {
    _giveractive = v;
    notifyListeners();
  }

  int _giverCompleted = 0;
  int get giverCompleted => _giverCompleted;
  setgiverCompleted(int v) {
    _giverCompleted = v;
    notifyListeners();
  }

  int _reciveractive = 0;
  int get reciveractive => _reciveractive;
  setreciveractive(int v) {
    _reciveractive = v;
    notifyListeners();
  }

  int _reciverRequested = 0;
  int get reciverRequested => _reciverRequested;
  setreciverRequested(int v) {
    _reciverRequested = v;
    notifyListeners();
  }

  RefreshController _activerefreshController =
      RefreshController(initialRefresh: false);
  RefreshController get activerefreshController => _activerefreshController;
  void activeonRefresh() async {
    _activerefreshController.refreshCompleted();
  }

  void activeonLoading() {
    if (_nextPageURL != '') {
      ApiUtilsClass.getNextHomePageData(
          provider: HomePage.provider,
          inactiverefreshController: _activerefreshController);
    } else {
      SnackBars.snackbar(
          c: Colors.red, key: _scaffoldKey, text: 'No more record.');
      _activerefreshController.loadComplete();
    }
  }

  RefreshController _inactiverefreshController =
      RefreshController(initialRefresh: false);
  RefreshController get inactiverefreshController => _inactiverefreshController;
  inactiveonRefresh() async {
    // monitor network fetch
    print('Now page is refresh');
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _activerefreshController.refreshCompleted();
  }

  void inactiveonLoading() {
    if (_nextPageURL != '') {
      ApiUtilsClass.getNextHomePageData(
          provider: HomePage.provider,
          inactiverefreshController: _inactiverefreshController);
    } else {
      SnackBars.snackbar(
          c: Colors.red, key: _scaffoldKey, text: 'No more record.');
      _inactiverefreshController.loadComplete();
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
