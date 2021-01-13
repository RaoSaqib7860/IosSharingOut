import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class BlockAddFood extends ChangeNotifier {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  TextEditingController _nameCon = TextEditingController();
  TextEditingController get nameCon => _nameCon;
  TextEditingController _disCon = TextEditingController();
  TextEditingController get disCon => _disCon;

  int _servigns = 1;
  int get servings => _servigns;
  setminiServings() {
    _servigns--;
    notifyListeners();
  }

  setaddServings() {
    _servigns++;
    notifyListeners();
  }

  String _starttime = '';
  String get startTime => _starttime;
  setStarttime(String val) {
    _starttime = val;
    notifyListeners();
  }

  String _endtime = '';
  String get endTime => _endtime;
  setendtime(String val) {
    _endtime = val;
    notifyListeners();
  }

  String _ustarttime = '';
  String get ustartTime => _ustarttime;
  setuStarttime(String val) {
    _ustarttime = val;
    notifyListeners();
  }

  String _uendtime = '';
  String get uendTime => _uendtime;
  setuendtime(String val) {
    _uendtime = val;
    notifyListeners();
  }

  bool _status = true;
  bool get status => _status;
  setstatus(bool val) {
    _status = val;
    notifyListeners();
  }

  String _lng = '';
  String get lng => _lng;
  setlng(String lng) {
    _lng = lng;
    notifyListeners();
  }

  String _lat = '';
  String get lat => _lat;
  setlat(String lng) {
    _lat = lng;
    notifyListeners();
  }

  bool _addingFood = false;
  bool get addingFood => _addingFood;
  setAddingFood(bool v) {
    _addingFood = v;
    notifyListeners();
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
        imageQuality: 30,
      );
      setImageFile(pickedFile);
    } catch (e) {}
  }
}
