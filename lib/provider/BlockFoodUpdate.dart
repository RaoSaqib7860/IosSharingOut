import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class BlockFoodUpDate extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController get nameCon => _nameCon;
  TextEditingController _disCon = TextEditingController();
  TextEditingController get disCon => _disCon;

  int _servigns = 0;
  int get servings => _servigns;
  setminiServings() {
    _servigns--;
    notifyListeners();
  }

  setinitialServings({int val, String ini}) {
    _servigns = val;
    if (ini == 'ini') {
      _servigns = val;
    } else {
      _servigns = val;
      notifyListeners();
    }
  }

  setaddServings() {
    _servigns++;
    notifyListeners();
  }

  String _starttime = '';
  String get startTime => _starttime;
  setStarttime({String val, String ini}) {
    if (ini == 'ini') {
      _starttime = val;
    } else {
      _starttime = val;
      notifyListeners();
    }
  }

  String _endtime = '';
  String get endTime => _endtime;
  setendtime({String val, String ini}) {
    if (ini == 'ini') {
      _endtime = val;
    } else {
      _endtime = val;
      notifyListeners();
    }
  }

  String _ustarttime = '';
  String get ustartTime => _ustarttime;
  setuStarttime({String val, String ini}) {
    if (ini == 'ini') {
      _ustarttime = val;
    } else {
      _ustarttime = val;
      notifyListeners();
    }
  }

  bool _addingFood = false;
  bool get addingFood => _addingFood;
  setAddingFood(bool v) {
    _addingFood = v;
    notifyListeners();
  }

  String _uendtime = '';
  String get uendTime => _uendtime;
  setuendtime({String val, String ini}) {
    if (ini == 'ini') {
      _uendtime = val;
    } else {
      _uendtime = val;
      notifyListeners();
    }
  }

  bool _status = false;
  bool get status => _status;
  setstatus({bool val, String ini}) {
    if (ini == 'ini') {
      _status = val;
    } else {
      _status = val;
      notifyListeners();
    }
  }

  File _imageFile;
  File get imageFile => _imageFile;
  setImageFile(PickedFile f) async {
    final filePath = f.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 600, minHeight: 1000, quality: 30);
    _imageFile = compressedImage;

    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  void onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 88,
      );
      setImageFile(pickedFile);
    } catch (e) {}
  }
}
