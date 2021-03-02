//import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/LocalWidget/LocliSpin.dart';
import 'dart:io';
import 'dart:async';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:SharingOut/provider/BlockFoodUpdate.dart';

class UpDateFoodData extends StatefulWidget {
  UpDateFoodData({Key key, this.mapData, this.index, this.serving})
      : super(key: key);
  final mapData;
  final String index;
  final String serving;
  @override
  _UpDateFoodDataState createState() => _UpDateFoodDataState();
}

class _UpDateFoodDataState extends State<UpDateFoodData> {
  List<Marker> myMarker = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Completer<GoogleMapController> _controller = Completer();
  LatLng latLng;
  DateFormat sdf2 = DateFormat("hh.mm aa");
  Future<void> getLocation() async {
    Position position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
      });
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null) {
        setState(() {
          latLng = LatLng(position.latitude, position.longitude);
        });
      }
    }
  }

  bool onMap = false;

  bool selectRidetoConform = false;
  bool opacity = false;
  @override
  void initState() {
    print('${widget.mapData}');
    String timespam = '${widget.mapData['start_time']}';
    String timespam2 = '${widget.mapData['end_time']}';
    String sub = timespam.substring(11, 19);
    String sub2 = timespam2.substring(11, 19);
    String startDate = timespam.substring(0, 10);
    String endDate = timespam2.substring(0, 10);
    print('$sub');
    final BlockFoodUpDate _provider =
        Provider.of<BlockFoodUpDate>(context, listen: false);
    _provider.nameCon.text = '${widget.mapData['name']}';
    _provider.disCon.text = '${widget.mapData['description']}';
    _provider.setinitialServings(ini: 'ini', val: int.parse(widget.serving));
    _provider.setstatus(ini: 'ini', val: widget.mapData['active']);
    _provider.setStarttime(ini: 'ini', val: sub);
    _provider.setendtime(ini: 'ini', val: sub2);
    _provider.setuStarttime(ini: 'ini', val: startDate);
    _provider.setuendtime(ini: 'ini', val: endDate);
    _gpsService();
    getLocation();
    super.initState();
  }

  Future _gpsService() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      _checkGps();
      return null;
    } else
      return true;
  }

  Future _checkGps() async {
    if (!(await Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get gurrent location"),
                content:
                    const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                       /* final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();*/
                      })
                ],
              );
            });
      }
    }
  }

  Future onBackPress(Completer<GoogleMapController> controller) async {
    final GoogleMapController controller = await _controller.future;
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final BlockFoodUpDate _provider = Provider.of<BlockFoodUpDate>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBackPress(_controller),
      child: SafeArea(
          child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: opacity == false ? 1 : 0,
                child: AnimatedContainer(
                  decoration: BoxDecoration(color: Colors.white),
                  child: getCurrentLocation(),
                  height: selectRidetoConform == true
                      ? height / 2.10
                      : height / 2.8,
                  width: width,
                  duration: Duration(milliseconds: 500),
                ),
              ),
              Container(
                child: SizedBox.expand(
                    child:
                        NotificationListener<DraggableScrollableNotification>(
                  onNotification:
                      (DraggableScrollableNotification notification) {
                    if (notification.extent > 0.7) {
                      setState(() {
                        opacity = true;
                      });
                    } else if (notification.extent < 1) {
                      setState(() {
                        opacity = false;
                      });
                    }
                    return true;
                  },
                  child: DraggableScrollableSheet(
                    maxChildSize: 1.0,
                    minChildSize: 0.65,
                    initialChildSize: 0.65,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return ListView(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            child: Container(
                              height: height / 4,
                              width: width,
                              child: InkWell(
                                child: InkWell(
                                  onTap: () {
                                    displayBottomSheet(context, _provider);
                                  },
                                  child: _provider.imageFile != null
                                      ? Image.file(
                                          File(_provider.imageFile.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Hero(
                                          tag: 'hero_tag+${widget.index}',
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${widget.mapData['image']}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                CupertinoActivityIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: AppThemes.mainThemes,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        color: Colors.black26,
                                        offset: Offset(3, 5))
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          AnimatedContainer(
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            duration: Duration(milliseconds: 800),
                            curve: Curves.ease,
                            width: width,
                            height: height / 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        3.0,
                                        5.0,
                                      ),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: _provider.nameCon,
                                style: TextStyle(
                                    color: AppThemes.mainThemes, fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(width / 40),
                                    labelText: 'Food Name',
                                    labelStyle: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.3,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          AnimatedContainer(
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            duration: Duration(milliseconds: 800),
                            curve: Curves.ease,
                            width: width,
                            height: height / 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        3.0,
                                        5.0,
                                      ),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(
                                controller: _provider.disCon,
                                maxLines: 5,
                                style: TextStyle(
                                    color: AppThemes.mainThemes, fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(width / 40),
                                    hintText: 'Description',
                                    hintStyle: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.3,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Servings',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Comfortaa',
                                      letterSpacing: 0.3,
                                      color: AppThemes.mainThemes,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (_provider.servings > 1) {
                                          _provider.setminiServings();
                                        }
                                      },
                                      child: Container(
                                        height: height / 35,
                                        width: width / 17.5,
                                        child: Center(
                                            child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                        decoration: BoxDecoration(
                                            color: AppThemes.mainThemes,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _provider.setaddServings();
                                      },
                                      child: Container(
                                        height: height / 35,
                                        width: width / 17.5,
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            color: AppThemes.mainThemes,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width / 50,
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: AppThemes.mainThemes,
                                    ),
                                    Text(
                                      _provider.servings == 0
                                          ? '${widget.mapData['number_of_serving']}'
                                          : '${_provider.servings}',
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: AppThemes.mainThemes,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Start time',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.3,
                                        color: AppThemes.mainThemes,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titlePadding:
                                                const EdgeInsets.all(0.0),
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                            content: SingleChildScrollView(
                                              child: TimePickerSpinner(
                                                is24HourMode: false,
                                                isShowSeconds: true,
                                                time: DateTime.now(),
                                                normalTextStyle: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black38),
                                                highlightedTextStyle: TextStyle(
                                                    fontSize: 24,
                                                    color:
                                                        AppThemes.mainThemes),
                                                spacing: 30,
                                                itemHeight: 60,
                                                isForce2Digits: true,
                                                minutesInterval: 1,
                                                onTimeChange: (time) {
                                                  _provider.setStarttime(
                                                      val:
                                                          '${time.hour}:${time.minute}:${time.second}');
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: height / 10,
                                      width: width / 5,
                                      child: _provider.startTime == ''
                                          ? Icon(
                                              Icons.alarm,
                                              color: AppThemes.mainThemes,
                                            )
                                          : Center(
                                              child: Text(
                                                '${sdf2.format(DateFormat('Hms').parse(_provider.startTime))}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Comfortaa',
                                                    letterSpacing: 0.3,
                                                    color: AppThemes.mainThemes,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[50],
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              SizedBox(
                                width: width / 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'End time',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.3,
                                        color: AppThemes.mainThemes,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titlePadding:
                                                const EdgeInsets.all(0.0),
                                            contentPadding:
                                                const EdgeInsets.all(0.0),
                                            content: SingleChildScrollView(
                                              child: TimePickerSpinner(
                                                is24HourMode: false,
                                                isShowSeconds: true,
                                                time: DateTime.now(),
                                                normalTextStyle: TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.black38),
                                                highlightedTextStyle: TextStyle(
                                                    fontSize: 24,
                                                    color:
                                                        AppThemes.mainThemes),
                                                spacing: 30,
                                                itemHeight: 60,
                                                isForce2Digits: true,
                                                minutesInterval: 1,
                                                onTimeChange: (time) {
                                                  _provider.setendtime(
                                                      val:
                                                          '${time.hour}:${time.minute}:${time.second}');
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: height / 10,
                                      width: width / 5,
                                      child: _provider.endTime == ''
                                          ? Icon(
                                              Icons.alarm,
                                              color: AppThemes.mainThemes,
                                            )
                                          : Center(
                                              child: Text(
                                                '${sdf2.format(DateFormat('Hms').parse(_provider.endTime))}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Comfortaa',
                                                    letterSpacing: 0.3,
                                                    color: AppThemes.mainThemes,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[50],
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Start Date',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.3,
                                        color: AppThemes.mainThemes,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime.now(),
                                          maxTime: DateTime(2025, 6, 7),
                                          theme: DatePickerTheme(
                                              headerColor: Colors.white,
                                              backgroundColor:
                                                  AppThemes.mainThemes,
                                              itemStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              doneStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          onChanged: (date) {
                                        String a = '$date';
                                        List st = a.split(' ');
                                        _provider.setuStarttime(
                                            val: '${st[0]}');
                                      },
                                          onConfirm: (date) {},
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: Container(
                                      height: height / 15,
                                      width: width / 5,
                                      child: Center(
                                        child: _provider.ustartTime == ''
                                            ? Icon(
                                                Icons.date_range,
                                                color: AppThemes.mainThemes,
                                              )
                                            : Text(
                                                '${_provider.ustartTime}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Comfortaa',
                                                    letterSpacing: 0.3,
                                                    color: AppThemes.mainThemes,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                      ),
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              ),
                              SizedBox(
                                width: width / 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'End Date',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.3,
                                        color: AppThemes.mainThemes,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: height / 50,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime.now(),
                                          maxTime: DateTime(2025, 6, 7),
                                          theme: DatePickerTheme(
                                              headerColor: Colors.white,
                                              backgroundColor:
                                                  AppThemes.mainThemes,
                                              itemStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              doneStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          onChanged: (date) {
                                        String a = '$date';
                                        List st = a.split(' ');
                                        _provider.setuendtime(val: '${st[0]}');
                                      },
                                          onConfirm: (date) {},
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    child: Container(
                                      height: height / 15,
                                      width: width / 5,
                                      child: Center(
                                        child: _provider.uendTime == ''
                                            ? Icon(
                                                Icons.date_range,
                                                color: AppThemes.mainThemes,
                                              )
                                            : Text(
                                                '${_provider.uendTime}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Comfortaa',
                                                    letterSpacing: 0.3,
                                                    color: AppThemes.mainThemes,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                      ),
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          SizedBox(
                            height: height / 20,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Comfortaa',
                                      letterSpacing: 0.3,
                                      color: Colors.black.withOpacity(0.7),
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _provider.status == false
                                          ? 'In Active'
                                          : 'Active',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.green.withOpacity(0.7),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Switch(
                                      value: _provider.status,
                                      onChanged: (value) {
                                        _provider.setstatus(val: value);
                                      },
                                      activeTrackColor: Colors.blueGrey[100],
                                      activeColor: AppThemes.mainThemes,
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (_provider.nameCon.text.isNotEmpty) {
                                if (_provider.disCon.text.isNotEmpty) {
                                  if (_provider.addingFood == false) {
                                    ApiUtilsClass.updateFoodData(
                                        provider: _provider,
                                        latLng: latLng,
                                        id: (widget.mapData['id']).toString(),
                                        url: '${widget.mapData['image']}');
                                    _provider.setAddingFood(true);
                                  }
                                } else {
                                  SnackBars.snackbar(
                                      c: Colors.red,
                                      key: _provider.scaffoldKey,
                                      text: 'Please Enter Name.');
                                }
                              } else {
                                SnackBars.snackbar(
                                    c: Colors.red,
                                    key: _provider.scaffoldKey,
                                    text: 'Please Enter Name.');
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: width / 5, right: width / 5),
                              height: height / 18,
                              width: width,
                              child: Center(
                                child: _provider.addingFood == true
                                    ? LocliSpin.spinKit(c: Colors.white)
                                    : Text(
                                        'Update',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Comfortaa',
                                            letterSpacing: 0.3,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                              decoration: BoxDecoration(
                                  color: AppThemes.mainThemes,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      spreadRadius: 2.0,
                                      offset: Offset(
                                        3.0,
                                        5.0,
                                      ),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                        ],
                        controller: scrollController,
                      );
                    },
                  ),
                )),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: width / 20, top: width / 20),
                  child: InkWell(
                    onTap: () {
                      onBackPress(_controller);
                    },
                    child: Icon(
                      Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget getCurrentLocation() {
    if (latLng == null) {
      return Container(
        child: CupertinoActivityIndicator(),
      );
    } else {
      return GoogleMap(
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: latLng == null ? LatLng(000.00, 00.00) : latLng,
          zoom: 17,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(myMarker),
        onTap: _handleTap,
      );
    }
  }

  _handleTap(LatLng tapedPoint) {
    print(tapedPoint);
    setState(() {
      latLng = tapedPoint;
      print(latLng);
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(tapedPoint.toString()),
          position: tapedPoint,
          draggable: true,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          onDragEnd: (dragableendPosition) {
            latLng = dragableendPosition;
          }));
    });
  }

  void displayBottomSheet(BuildContext context, BlockFoodUpDate provider) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(width / 30),
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            provider.onImageButtonPressed(ImageSource.camera,
                                context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 100),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/camera.png'),
                          ),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            provider.onImageButtonPressed(ImageSource.gallery,
                                context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 35),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/gallary.png'),
                          ),
                        ),
                        Text(
                          'Gallary',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
        });
  }
}
