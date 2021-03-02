import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockLogin extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  // Login acssess model////////////////////////////////////////////////////////////
  TextEditingController _loginemailNameCon = TextEditingController();
  TextEditingController get loginemailCon => _loginemailNameCon;
  TextEditingController _loginpasswordNameCon = TextEditingController();
  TextEditingController get loginpasswordCon => _loginpasswordNameCon;
  bool _loading = false;
  bool get loding => _loading;
  setLoadiing(bool val) {
    _loading = val;
    notifyListeners();
  }
}
