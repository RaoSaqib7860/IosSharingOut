import 'dart:async';
import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/ReciverOrderPageHome.dart';
import 'package:SharingOut/SharedPrefence/SharedPreference.dart';
import 'package:SharingOut/WebScocket.dart';
import 'package:SharingOut/provider/BLockWebScocket.dart';
import 'package:SharingOut/provider/BlockGiverMode.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';

class GiverModeOrderPageHome extends StatefulWidget {
  GiverModeOrderPageHome({Key key, this.list}) : super(key: key);
  final list;
  @override
  _GiverModeOrderPageHomeState createState() => _GiverModeOrderPageHomeState();
}

class _GiverModeOrderPageHomeState extends State<GiverModeOrderPageHome> {
  Set<Polyline> lines = {};
  double CAMERA_ZOOM = 14;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  LatLng SOURCE_LOCATION;
  LatLng DEST_LOCATION;
  Completer<GoogleMapController> _controller = Completer();
  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = Platform.isAndroid
      ? 'AIzaSyAawPM19Hr5XU6mCGME2GybZDj2-K3mc20'
      : 'AIzaSyAyoBh_jZM1FgjKqCFO4RZuRs2TWM9ronk';
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  bool load = false;
  bool status = true;
  bool onMap = false;
  bool onOnetime = false;
  int actionIndex = 1;
  String delivered = 'Deliver food';
  @override
  void initState() {
    final BlockGiverMode _provider =
        Provider.of<BlockGiverMode>(context, listen: false);
    _provider.setListMain(widget.list);
    DEST_LOCATION = LatLng(double.parse('${_provider.listmain['food']['latitude']}'),
        double.parse('${_provider.listmain['food']['longitude']}'));
    print('${widget.list}');
    _gpsService();
    getLocation(_provider);
    setSourceAndDestinationIcons();
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
                        final AndroidIntent intent = AndroidIntent(
                            action:
                                'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                        _gpsService();
                      })
                ],
              );
            });
      }
    }
  }

  updatepolyline(BlockGiverMode provider) async {
    if (status == true) {
      DEST_LOCATION = LatLng(
          double.parse('${provider.listmain['food']['latitude']}'),
          double.parse('${provider.listmain['food']['longitude']}'));
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
        PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
      );
      if (result.points.isNotEmpty) {
        if (polylineCoordinates != null) {
          polylineCoordinates.clear();
        }
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });

        setState(() {
          Polyline polyline = Polyline(
              polylineId: PolylineId("poly"),
              color: Color.fromARGB(255, 40, 122, 198),
              points: polylineCoordinates);
          _polylines.add(polyline);
        });
      }
      updateMapPins(DEST_LOCATION);
    }
  }

  void updateMapPins(LatLng latlng) {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: destinationIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: latlng,
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  Future<void> getLocation(BlockGiverMode provider) async {
    Position position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      setState(() {
        SOURCE_LOCATION = LatLng(position.latitude, position.longitude);
      });
      getlistofProgress(provider);
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null) {
        setState(() {
          SOURCE_LOCATION = LatLng(position.latitude, position.longitude);
        });
      }
      getlistofProgress(provider);
    }
  }

  getlistofProgress(BlockGiverMode provider) async {
    if (onOnetime == false) {
      Future.delayed(Duration(seconds: 0), () async {
        if (mounted && status == true) {
          await ApiUtilsClass.updateOrderStaeForGiver(
              id: '${provider.listmain['order_id']}', provider: provider);
        }
      }).then((value) => {
            if (mounted && status == true)
              {
                setState(() {
                  onOnetime = true;
                  load = true;
                }),
                getlistofProgress(provider)
              }
          });
    } else {
      if (mounted && status == true) {
        Future.delayed(Duration(seconds: 10), () async {
          if (mounted && status == true) {
            await ApiUtilsClass.updateOrderStaeForGiver(
                id: '${provider.listmain['order_id']}', provider: provider);
          }
        }).then((value) => {
              if (mounted && status == true)
                {updatepolyline(provider), getlistofProgress(provider)}
            });
      }
    }
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
  }

  Future onbackpress(
    BuildContext context,
  ) async {
    setState(() {
      status = false;
    });
    print('back');
    Navigator.of(context).pop();
    SharedPreferenceClass.addmode('G');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
          duration: Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft,
          child: ChangeNotifierProvider(
            create: (_) => BlockHomePage(),
            child: HomePage(
              mode: prefs.getString('mode'),
            ),
          )),
      ModalRoute.withName('/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BlockGiverMode _provider = Provider.of<BlockGiverMode>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: WillPopScope(
        onWillPop: () => onbackpress(context),
        child: Scaffold(
            key: _provider.scaffoldKey,
            floatingActionButton: Column(
              children: [
                SizedBox(
                  height: height / 1.5,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (_provider.loading == false) {
                    } else {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockWebScocket(),
                                child: WebScocket(
                                  id: _provider.listmain['receiver_id'],
                                  name: _provider.listmain['receiver_name'],
                                  idss: _provider.listmain['receiver_id'],
                                ),
                              )));
                    }
                  },
                  backgroundColor: AppThemes.balckOpacityThemes,
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            backgroundColor: Colors.white,
            body: Container(
              height: height,
              width: width,
              child: load == false
                  ? Center(child: CircularProgressIndicator())
                  : Stack(
                      children: [
                        Container(
                          height: height,
                          width: width,
                          margin: EdgeInsets.only(bottom: height / 12),
                          child: GoogleMap(
                              myLocationEnabled: status,
                              compassEnabled: status,
                              tiltGesturesEnabled: status == true ? false : true,
                              markers: _markers,
                              polylines: lines,
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                  zoom: CAMERA_ZOOM,
                                  bearing: CAMERA_BEARING,
                                  tilt: CAMERA_TILT,
                                  target: SOURCE_LOCATION),
                              onMapCreated: onMapCreated),
                        ),
                        _provider.listofmainprogress['reached'] == false
                            ? SizedBox()
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: height,
                                  width: width,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Receiver is Arrived',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Comfortaa',
                                            letterSpacing: 0.5),
                                      ),
                                      SizedBox(
                                        height: height / 30,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_provider.deliverd ==
                                              'Deliver food') {
                                            ApiUtilsClass.deliveryAcceptedGiver(
                                                context,
                                                '${_provider.listmain['order_id']}');
                                            _provider.setDelivered(
                                                'Waiting for acceptance');
                                          }
                                          if (_provider.deliverd == 'Accepted') {
                                            ApiUtilsClass.deliveryAcceptedReciver(
                                                context,
                                                '${_provider.listmain['order_id']}');
                                            setState(() {
                                              status = false;
                                            });
                                            getlistofProgress(_provider);
                                            onbackpress(context);
                                          }
                                        },
                                        child: Container(
                                          height: height / 16,
                                          width: width / 2,
                                          child: Center(
                                            child: Text(
                                              '${_provider.deliverd}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Comfortaa',
                                                  letterSpacing: 0.5),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: delivered == 'Deliver food'
                                                  ? AppThemes.mainThemes
                                                  : delivered ==
                                                          'Waiting for acceptance'
                                                      ? AppThemes.mainThemes
                                                          .withOpacity(0.3)
                                                      : AppThemes.mainThemes,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      )
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: height / 12,
                            width: width,
                            child: Row(
                              children: [
                                _provider.listofmainprogress['accepted'] == true
                                    ? _provider.listofmainprogress['reached'] ==
                                            true
                                        ? Text(
                                            '     Please deliver food',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Comfortaa',
                                                letterSpacing: 0.5),
                                          )
                                        : Text(
                                            '     Please wait for receiver',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Comfortaa',
                                                letterSpacing: 0.5),
                                          )
                                    : InkWell(
                                        onTap: () {
                                          ApiUtilsClass.ricevrexceptRequest(
                                              id: '${_provider.listmain['order_id']}',
                                              provider: _provider);
                                          setState(() {
                                            actionIndex = 2;
                                          });
                                        },
                                        child: actionIndex <= 1
                                            ? Text(
                                                '     Accept Request',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Comfortaa',
                                                    letterSpacing: 0.5),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: width / 15),
                                                child: CircularProgressIndicator(
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                      ),
                                InkWell(
                                  onTap: () {
                                    ApiUtilsClass.reciverCancel(context,
                                        '${_provider.listmain['order_id']}');
                                    setState(() {
                                      status = false;
                                    });
                                    getlistofProgress(_provider);
                                    onbackpress(context);
                                  },
                                  child: Text(
                                    'Cancel    ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Comfortaa',
                                        letterSpacing: 0.5),
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            decoration:
                                BoxDecoration(color: AppThemes.mainThemes),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(
                                width / 20
                                ),
                            child: InkWell(
                              onTap: () {
                                onbackpress(context);
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
            )),
      ),
    );
  }
  _getPolyline(){
    lines.add(
      Polyline(
        points: [
          LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
          LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
        ],
        endCap: Cap.squareCap,
        geodesic: false,
        color: Colors.blue,
        polylineId: PolylineId("line_one"),
      ),
    );
  }
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    if (status == true) {
      setMapPins();
      _getPolyline();
    }
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: destinationIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: BitmapDescriptor.defaultMarker));
    });
  }
}
