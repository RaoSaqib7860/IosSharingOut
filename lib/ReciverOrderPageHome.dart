import 'dart:async';
import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:SharingOut/LocalWidget/pin_pill_info.dart';
import 'package:SharingOut/SharedPrefence/SharedPreference.dart';
import 'package:SharingOut/WebScocket.dart';
import 'package:SharingOut/provider/BLockWebScocket.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockReciverOrderPageHome.dart';

class ReciverOrderPageHome extends StatefulWidget {
  ReciverOrderPageHome({Key key, this.id, this.list, this.hselist})
      : super(key: key);
  final id;
  final Map list;
  final String hselist;
  @override
  _ReciverOrderPageHomeState createState() => _ReciverOrderPageHomeState();
}

class _ReciverOrderPageHomeState extends State<ReciverOrderPageHome>
    with WidgetsBindingObserver {
  double CAMERA_ZOOM = 13;
  double CAMERA_TILT = 80;
  double CAMERA_BEARING = 30;
  LatLng SOURCE_LOCATION = LatLng(33.5211342, 73.1044593);
  LatLng DEST_LOCATION = LatLng(33.5969, 73.0528);
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = Platform.isAndroid?'AIzaSyAawPM19Hr5XU6mCGME2GybZDj2-K3mc20':'AIzaSyAyoBh_jZM1FgjKqCFO4RZuRs2TWM9ronkS';
// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
// the user's initial location and current location
// as it moves
  LocationData currentLocation;
// a reference to the destination location
  LocationData destinationLocation;
// wrapper around the location API
  Location location;
  double pinPillPosition = -100;
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);
  PinInformation sourcePinInfo;
  PinInformation destinationPinInfo;
  DateFormat sdf2 = DateFormat("hh.mm aa");

  bool onMap = false;
  bool onOnetime = false;
  int curentStatus = 1;
  @override
  void initState() {
    final BlockReciverOrderPageHome _provider =
        Provider.of<BlockReciverOrderPageHome>(context, listen: false);
    _gpsService();
    location = new Location();
    polylinePoints = PolylinePoints();
    locationUpdate(_provider);
    // set custom marker pins
    setSourceAndDestinationIcons();
    // set the initial location
    setInitialLocation(_provider);
    getFoodDetail(_provider);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  locationUpdate(BlockReciverOrderPageHome provider) async {
    if (provider.status == true) {
      location.onLocationChanged().listen((LocationData cLoc) {
        currentLocation = cLoc;
        updatePinOnMap();
      });
    }
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

  getlistofProgress(BlockReciverOrderPageHome provider) async {
    if (onOnetime == false) {
      Future.delayed(Duration(seconds: 00), () async {
        if (mounted && provider.status == true) {
          await ApiUtilsClass.updateOrderDetailPage(
              provider, '${provider.listmain['order_id']}');
        }
      }).then((value) => {
            if (mounted && provider.status == true)
              {
                setState(() {
                  onOnetime = true;
                }),
                getlistofProgress(provider)
              }
          });
    } else {
      if (mounted && provider.status == true) {
        Future.delayed(Duration(seconds: 10), () async {
          if (mounted && provider.status == true) {
            await ApiUtilsClass.updateOrderDetailPage(
                provider, '${provider.listmain['order_id']}');
            await ApiUtilsClass.reciverLocationUpdate(
                currentLocation, '${provider.listmain['order_id']}');
          }
        }).then((value) => {
              if (mounted && provider.status == true)
                {getlistofProgress(provider)}
            });
      }
    }
  }

  apiCalling() {
    Future.delayed(Duration(seconds: 10), () async {
      await ApiUtilsClass.reciverLocationUpdate(
          currentLocation, '${widget.id}');
    }).then((value) => {apiCalling()});
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
              devicePixelRatio: 80,
            ),
            'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 80,
      ),
      'assets/destination_map_marker.png',
    ).then((onValue) {
      destinationIcon = onValue;
    });
  }

  Future setInitialLocation(BlockReciverOrderPageHome provider) async {
    currentLocation = await location.getLocation();
    if (provider.listmain != null) {
      DEST_LOCATION = LatLng(provider.listmain['food']['latitude'],
          provider.listmain['food']['longitude']);
    } else {
      DEST_LOCATION = LatLng(33.5969, 73.0528);
    }

    destinationLocation = LocationData.fromMap({
      "latitude": DEST_LOCATION.latitude,
      "longitude": DEST_LOCATION.longitude
    });
  }

  bool selectRidetoConform = false;
  bool opacity = false;

  getFoodDetail(BlockReciverOrderPageHome provider) async {
    if (widget.hselist == 'yes') {
      provider.setListMain(widget.list);
      await setInitialLocation(provider)
          .then((value) => {getlistofProgress(provider)});
    } else {
      await ApiUtilsClass.getOrderDetailPage(provider, '${widget.id}')
          .then((value) async => {await setInitialLocation(provider)})
          .then((value) => {getlistofProgress(provider)});
    }
  }

  Future onbackpress(BlockReciverOrderPageHome provider,
      Completer<GoogleMapController> controller) async {
    provider.setstatus(false);
    getlistofProgress(provider);
    SharedPreferenceClass.addmode('R');
    Navigator.of(context).pop();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Navigator.pushAndRemoveUntil(
      provider.scaffoldKey.currentContext,
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
    final BlockReciverOrderPageHome _provider =
        Provider.of<BlockReciverOrderPageHome>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onbackpress(_provider, _controller),
      child: SafeArea(
          child: Scaffold(
        floatingActionButton: Column(
          children: [
            SizedBox(
              height: height / 1.5,
            ),
            FloatingActionButton(
              onPressed: () {
                if (_provider.loading == false) {
                  SnackBars.snackbar(
                      c: Colors.green,
                      key: _provider.scaffoldKey,
                      text: 'We have sent you OTP to verify your email');
                } else {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(milliseconds: 500),
                          type: PageTransitionType.rightToLeft,
                          child: ChangeNotifierProvider(
                            create: (_) => BlockWebScocket(),
                            child: WebScocket(
                              id: _provider.listmain['giver_id'],
                              name: _provider.listmain['giver_name'],
                              idss: _provider.listmain['giver_id'],
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
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: _provider.loading == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _provider.ok == true
                ? Center(
                    child: Text(
                      '${_provider.errorText}',
                      style: TextStyle(
                          color: AppThemes.balckOpacityThemes,
                          fontFamily: 'Comfortaa',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        height: height,
                        width: width,
                        child: Stack(
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 200),
                              opacity: opacity == false ? 1 : 0,
                              child: AnimatedContainer(
                                child: GoogleMap(
                                    myLocationEnabled: true,
                                    compassEnabled: true,
                                    tiltGesturesEnabled: false,
                                    markers: _markers,
                                    polylines: _polylines,
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(currentLocation.latitude,
                                            currentLocation.longitude),
                                        zoom: CAMERA_ZOOM,
                                        tilt: CAMERA_TILT,
                                        bearing: CAMERA_BEARING),
                                    onTap: (LatLng loc) {
                                      pinPillPosition = -100;
                                    },
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      controller.setMapStyle(Utils.mapStyles);
                                      _controller.complete(controller);
                                      // my map has completed being created;
                                      // i'm ready to show the pins on the map
                                      showPinsOnMap();
                                    }),
                                decoration: BoxDecoration(color: Colors.white),
                                height: selectRidetoConform == true
                                    ? height / 2.1
                                    : height / 2.1,
                                width: width,
                                duration: Duration(milliseconds: 500),
                              ),
                            ),
                            Container(
                              child: SizedBox.expand(
                                  child: NotificationListener<
                                      DraggableScrollableNotification>(
                                onNotification: (DraggableScrollableNotification
                                    notification) {
                                  if (notification.extent > 0.5) {
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
                                  minChildSize: 0.5,
                                  initialChildSize: 0.5,
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
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${_provider.listmain['food']['image']}",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  CupertinoActivityIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
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
                                        Container(
                                          padding: EdgeInsets.all(
                                            height / 30,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Title',
                                                style: TextStyle(
                                                    color: AppThemes
                                                        .balckOpacityThemes,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: height / 100,
                                              ),
                                              Text(
                                                '${_provider.listmain['food']['name']}',
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: height / 50,
                                              ),
                                              Text(
                                                'Description',
                                                style: TextStyle(
                                                    color: AppThemes
                                                        .balckOpacityThemes,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: height / 100,
                                              ),
                                              Text(
                                                '${_provider.listmain['food']['description']}',
                                                style: TextStyle(
                                                    color: Colors.black38,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      controller: scrollController,
                                    );
                                  },
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      _provider.loading == false
                          ? SizedBox()
                          : _provider.listofmainprogress['reached'] == true
                              ? Container(
                                  height: height,
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Reached',
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
                                      _provider.listofmainprogress[
                                                  'delivered'] ==
                                              true
                                          ? InkWell(
                                              onTap: () {
                                                ApiUtilsClass
                                                    .deliveryAcceptedReciver(
                                                        context,
                                                        '${_provider.listmain['order_id']}');
                                                _provider.setstatus(false);
                                                getlistofProgress(_provider);
                                                onbackpress(
                                                    _provider, _controller);
                                              },
                                              child: Container(
                                                height: height / 16,
                                                width: width / 2,
                                                child: Center(
                                                  child: Text(
                                                    'Delivery Accepted',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Comfortaa',
                                                        letterSpacing: 0.5),
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: AppThemes.mainThemes,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                              ),
                                            )
                                          : Container(
                                              height: height / 16,
                                              width: width / 2,
                                              child: Center(
                                                child: Text(
                                                  'Waiting for delivery',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Comfortaa',
                                                      letterSpacing: 0.5),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: AppThemes.mainThemes
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                            )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5)),
                                )
                              : SizedBox(),
                      _provider.loading == false
                          ? SizedBox()
                          : _provider.listofmainprogress['accepted'] == true
                              ? SizedBox()
                              : Container(
                                  height: height,
                                  width: width,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      Center(
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(top: height / 8),
                                          child: Text(
                                            'Waiting for giver acceptence',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Comfortaa',
                                                letterSpacing: 0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                      _provider.loading == false
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: height / 10,
                                width: width,
                                child: Row(
                                  children: [
                                    _provider.listofmainprogress['accepted'] ==
                                            true
                                        ? InkWell(
                                            onTap: () {
                                              ApiUtilsClass.reciverReached(
                                                  '${_provider.listmain['order_id']}');
                                              setState(() {
                                                curentStatus = 2;
                                              });
                                            },
                                            child: _provider.listofmainprogress[
                                                        'reached'] ==
                                                    true
                                                ? SizedBox()
                                                : curentStatus == 1
                                                    ? Text(
                                                        '     Reached',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'Comfortaa',
                                                            letterSpacing: 0.5),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    width / 15),
                                                        child:
                                                            CircularProgressIndicator(
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                          )
                                        : Container(
                                            child: Text(
                                              '     Request sent',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Comfortaa',
                                                  letterSpacing: 0.5),
                                            ),
                                          ),
                                    InkWell(
                                      onTap: () {
                                        ApiUtilsClass.reciverCancel(context,
                                            '${_provider.listmain['order_id']}');
                                        _provider.setstatus(false);
                                        getlistofProgress(_provider);
                                        onbackpress(_provider, _controller);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                decoration:
                                    BoxDecoration(color: AppThemes.mainThemes),
                              ),
                            ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width / 20, top: width / 20),
                          child: InkWell(
                            onTap: () {
                              onbackpress(_provider, _controller);
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
    );
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition =
        LatLng(destinationLocation.latitude, destinationLocation.longitude);

    sourcePinInfo = PinInformation(
        locationName: "Start Location",
        location: SOURCE_LOCATION,
        pinPath: "assets/driving_pin.png",
        avatarPath: "assets/friend1.jpg",
        labelColor: Colors.blueAccent);

    destinationPinInfo = PinInformation(
        locationName: "End Location",
        location: DEST_LOCATION,
        pinPath: "assets/destination_map_marker.png",
        avatarPath: "assets/friend2.jpg",
        labelColor: Colors.purple);

    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        onTap: () {
          setState(() {
            currentlySelectedPin = sourcePinInfo;
            pinPillPosition = 0;
          });
        },
        icon: BitmapDescriptor.defaultMarker));
    // destination pin
    _markers.add(Marker(
      markerId: MarkerId('destPin'),
      position: destPosition,
      onTap: () {
        setState(() {
          currentlySelectedPin = destinationPinInfo;
          pinPillPosition = 0;
        });
      },
    ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(currentLocation.latitude, currentLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 2, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      sourcePinInfo.location = pinPosition;

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          onTap: () {
            setState(() {
              currentlySelectedPin = sourcePinInfo;
              pinPillPosition = 0;
            });
          },
          position: pinPosition, // updated position
          icon: sourceIcon));
    });
  }
}

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
