import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BlockAccount extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  TextEditingController _editCon = TextEditingController();
  TextEditingController get editCon => _editCon;

  String _name;
  String get name => _name;
  setName(String n, bool b) {
    if (b == false) {
      _name = n;
    } else {
      _name = n;
      notifyListeners();
    }
  }

  String _statement = '';
  String get statement => _statement;
  setstatement(String n) {
    _statement = n;
    notifyListeners();
  }

  int _rating = 0;
  int get rating => _rating;
  setrating(int n) {
    _rating = n;
    notifyListeners();
  }

  int _review = 0;
  int get review => _review;
  setreview(int n) {
    _review = n;
    notifyListeners();
  }

  String _profile = '';
  String get profile => _profile;
  setprofile(String n) {
    _profile = n;
    notifyListeners();
  }

  String _email;
  String get email => _email;
  setemail(String n, bool b) {
    if (b == false) {
      _email = n;
    } else {
      _email = n;
      notifyListeners();
    }
  }

  String _phone;
  String get phone => _phone;
  setphone(String n, bool b) {
    if (b == false) {
      _phone = n;
    } else {
      _phone = n;
      notifyListeners();
    }
  }

  PickedFile _imageFile;
  PickedFile get imageFile => _imageFile;
  setImageFile(PickedFile f) {
    _imageFile = f;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  void onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setImageFile(pickedFile);
    } catch (e) {}
  }
}
