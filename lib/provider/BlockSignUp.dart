import 'package:flutter/material.dart';

class BlockSignUp extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _signemailNameCon = TextEditingController();
  TextEditingController get signemailCon => _signemailNameCon;
  TextEditingController _signpasswordNameCon = TextEditingController();
  TextEditingController get signpasswordCon => _signpasswordNameCon;
  TextEditingController _signPhoneCon = TextEditingController();
  TextEditingController get signPhoneCon => _signPhoneCon;
  TextEditingController _sigUserNameCon = TextEditingController();
  TextEditingController get sigUserNameCon => _sigUserNameCon;

  bool _loading = false;
  bool get loding => _loading;
  setLoadiing(bool val) {
    _loading = val;
    notifyListeners();
  }
}
