import 'dart:async';
import 'dart:io';
import 'package:SharingOut/LocalWidget/NoconnectionDailog.dart';
import 'package:SharingOut/Services/InternetConnectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/Authentication/SignUpPage.dart';
import 'package:SharingOut/Authentication/VerifyNumber.dart';
import 'package:SharingOut/LocalWidget/LocliSpin.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:SharingOut/provider/BlockLogin.dart';
import 'package:SharingOut/provider/BlockSignUp.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool anim = false;
  @override
  void initState() {
    internet();
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  internet() async {
    await InterNetConnectivity.chekInternetConnection();
    if (InterNetConnectivity.internet == false) {
      NoConnectionDailog.connection(context);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final BlockLogin _provider = Provider.of<BlockLogin>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(width / 15),
          height: height,
          width: width,
          child: ListView(
            children: [
              SizedBox(
                height: height / 10,
              ),
              Text(
                'Login',
                style: TextStyle(
                    color: AppThemes.mainThemes,
                    fontSize: 40,
                    fontFamily: 'Comfortaa',
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height / 60,
              ),
              Text(
                'Please Sign in to Continue .',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height / 10,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
                width: width,
                height: anim == false ? 0 : height / 14,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2.0,
                    offset: Offset(
                      3.0,
                      5.0,
                    ),
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: width / 20,
                    ),
                    Icon(
                      Icons.phone_iphone,
                      size: 16,
                      color: AppThemes.mainThemes,
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      '+92',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 14,
                          letterSpacing: 0.5,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _provider.loginemailCon,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(
                            color: AppThemes.mainThemes,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(width / 40),
                            hintText: '3331234567',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                                letterSpacing: 0.3,
                                color: Colors.black12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
                width: width,
                height: anim == false ? 0 : height / 14,
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
                    obscureText: true,
                    controller: _provider.loginpasswordCon,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock_open,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Password',
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
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                   // Navigator.push(context, MaterialPageRoute(builder: (c)=>MapScreen()));
                   if (_provider.loginemailCon.text.isNotEmpty &&
                        _provider.loginpasswordCon.text.isNotEmpty) {
                     // print('Login Calling');
                      _provider.setLoadiing(true);
                      ApiUtilsClass.loginCalling(provider: _provider);
                    } else {
                      SnackBars.snackbar(
                          c: Colors.red,
                          text: 'Please Fill up All Fieldes.',
                          key: _provider.scaffoldKey);
                    }
                  },
                  child: Container(
                    height: height / 18,
                    width: width / 4,
                    child: _provider.loding == false
                        ? Row(
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Comfortaa',
                                    letterSpacing: 0.3,
                                    fontSize: 12),
                              ),
                              SizedBox(width: width / 100),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          )
                        : Center(
                            child: LocliSpin.spinKit(c: Colors.white),
                          ),
                    decoration: BoxDecoration(
                        color: AppThemes.mainThemes,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => VerifyNumber(
                                  wich: 'forgot',
                                )));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: AppThemes.mainThemes,
                        fontSize: 11,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comfortaa'),
                  ),
                ),
              ),
              SizedBox(
                height: height / 4.2,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Text(
                      'Don\'t have an account?   ',
                      style: TextStyle(
                          color: Colors.black26,
                          letterSpacing: 0.5,
                          fontSize: 12,
                          fontFamily: 'Comfortaa'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 500),
                                type: PageTransitionType.rightToLeft,
                                child: ChangeNotifierProvider(
                                  create: (_) => BlockSignUp(),
                                  child: SignUpPage(),
                                )));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: AppThemes.mainThemes,
                            fontSize: 12,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa'),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;
  double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  double _destLatitude = 6.849660, _destLongitude = 3.648190;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = 'AIzaSyAyoBh_jZM1FgjKqCFO4RZuRs2TWM9ronk';

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Platform.isAndroid
            ? 'AIzaSyAawPM19Hr5XU6mCGME2GybZDj2-K3mc20'
            : 'AIzaSyAyoBh_jZM1FgjKqCFO4RZuRs2TWM9ronk',
        PointLatLng(_originLatitude, _originLongitude),
        PointLatLng(_destLatitude, _destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
   // print('${result.points}');
    if (result.points.isNotEmpty) {
      print('not empty');
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }else{
      print('is empty');
    }
    _addPolyLine();
  }
}