import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:intl/intl.dart';
import 'package:SharingOut/GiverActiveRequest.dart';
import 'package:SharingOut/LocalWidget/ImageViewer.dart';
import 'package:SharingOut/LocalWidget/LocliSpin.dart';
import 'package:SharingOut/ReciverOrderPageHome.dart';
import 'package:SharingOut/UpDateFood.dart';
import 'package:SharingOut/UserDetailPage.dart';
import 'package:SharingOut/provider/BlockFoodUpdate.dart';
import 'package:SharingOut/provider/BlockGiverActiveRequest.dart';
import 'package:SharingOut/provider/BlockGiverMode.dart';
import 'package:SharingOut/provider/BlockReciverOrderPageHome.dart';
import 'package:SharingOut/provider/BlockUserDetail.dart';

class FoodDetailPage extends StatefulWidget {
  FoodDetailPage({Key key, this.mapdata, this.index, this.edit, this.mode})
      : super(key: key);
  final mapdata;
  final String index;
  final String edit;
  final String mode;
  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  DateFormat sdf2 = DateFormat("hh.mm aa");
  String startTime;
  String endTime;
  bool loading = false;
  String startDate;
  String endDate;

  double CAMERA_ZOOM = 15;
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
  String googleAPIKey = Platform.isAndroid?"AIzaSyAawPM19Hr5XU6mCGME2GybZDj2-K3mc20":"AIzaSyAyoBh_jZM1FgjKqCFO4RZuRs2TWM9ronk";
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  bool load = false;
  bool status = true;
  bool onMap = false;
  bool onOnetime = false;
  int actionIndex = 1;
  String delivered = 'Deliver food';
  bool mapLoding = false;
  @override
  void initState() {
    String s = '${widget.mapdata['start_time']}';
    startTime = s.substring(11, 19);
    startDate = s.substring(0, 10);
    String e = '${widget.mapdata['end_time']}';
    endTime = e.substring(11, 19);
    endDate = e.substring(0, 10);
    DEST_LOCATION =
        LatLng(widget.mapdata['latitude'], widget.mapdata['longitude']);
    apiCalling();
    _gpsService();
    getLocation();
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
                        Navigator.of(context).pop();
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

  updatepolyline(BlockGiverMode provider) async {
    DEST_LOCATION = LatLng(double.parse(provider.listmain['food']['latitude']),
        double.parse(provider.listmain['food']['longitude']));
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
        // create a Polyline instance
        // with an id, an RGB color and the list of LatLng pairs
        Polyline polyline = Polyline(
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);

        // add the constructed polyline as a set of points
        // to the polyline set, which will eventually
        // end up showing up on the map
        _polylines.add(polyline);
      });
    }
    updateMapPins(DEST_LOCATION);
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

  Future<void> getLocation() async {
    Position position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      setState(() {
        SOURCE_LOCATION = LatLng(position.latitude, position.longitude);
        setState(() {
          mapLoding = true;
        });
      });
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        SOURCE_LOCATION = LatLng(position.latitude, position.longitude);
        setState(() {
          mapLoding = true;
        });
      });
    }
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/driving_pin.png');
  }

  Future onbackpress(Completer<GoogleMapController> controller) async {
    final GoogleMapController controller = await _controller.future;
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
    setState(() {
      status = false;
    });
    Navigator.of(context).pop();
  }

  apiCalling() async {
    await ApiUtilsClass.addNoOfViewa('${widget.mapdata['id']}');
  }

  bool opacity = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onbackpress(_controller),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: opacity == false ? 1 : 0,
                child: Container(
                  height: height / 2.5,
                  width: width,
                  margin: EdgeInsets.only(bottom: height / 12),
                  child: mapLoding == false
                      ? CupertinoActivityIndicator()
                      : GoogleMap(
                          myLocationEnabled: true,
                          compassEnabled: true,
                          tiltGesturesEnabled: false,
                          markers: _markers,
                          polylines: _polylines,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              zoom: CAMERA_ZOOM,
                              bearing: CAMERA_BEARING,
                              tilt: CAMERA_TILT,
                              target: SOURCE_LOCATION),
                          onMapCreated: onMapCreated),
                ),
              ),
              Container(
                child: SizedBox.expand(
                    child:
                        NotificationListener<DraggableScrollableNotification>(
                  onNotification:
                      (DraggableScrollableNotification notification) {
                    if (notification.extent > 0.65) {
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
                    minChildSize: 0.6,
                    initialChildSize: 0.6,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return ListView(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ImageViewer(
                                        image: '${widget.mapdata['image']}',
                                      )));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Container(
                                height: height / 4,
                                width: width,
                                child: Hero(
                                  tag: 'hero_tag+${widget.index}',
                                  child: CachedNetworkImage(
                                    imageUrl: "${widget.mapdata['image']}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          widget.edit == 'no'
                              ? Container(
                                  height: height / 14,
                                  width: width,
                                  padding: EdgeInsets.only(
                                      left: width / 15, right: width / 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${widget.mapdata['name']}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Comfortaa',
                                            letterSpacing: 0.3,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: Duration(
                                                      milliseconds: 500),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: ChangeNotifierProvider(
                                                    create: (_) =>
                                                        BLockUserDetail(),
                                                    child: UserDetailPage(
                                                      id: '${widget.mapdata['giver_id']}',
                                                    ),
                                                  )));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                                '${widget.mapdata['giver_name']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Comfortaa',
                                                  letterSpacing: 0.3,
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: width / 30,
                                            ),
                                            CircularProfileAvatar(
                                              '${widget.mapdata['profile_picture']}',
                                              elevation: 6,
                                              radius: height / 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppThemes.mainThemes),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: AppThemes.mainThemes),
                                  height: height / 14,
                                  width: width,
                                  child: Center(
                                    child: Text(
                                      '${widget.mapdata['name']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: height / 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Row(
                              children: [
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Comfortaa',
                                      letterSpacing: 0.3,
                                      color: AppThemes.mainThemes,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height: height / 30,
                                  width: width / 5,
                                  child: Center(
                                    child: Text(
                                      'Available',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppThemes.mainThemes,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.only(
                                left: width / 20, right: width / 20),
                            child: Text(
                              '${widget.mapdata['description']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Comfortaa',
                                  letterSpacing: 0.3,
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
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
                                    Icon(
                                      Icons.person,
                                      color: AppThemes.mainThemes,
                                    ),
                                    Text(
                                      '${widget.mapdata['number_of_serving']}',
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
                            height: height / 30,
                          ),
                          Container(
                            width: width,
                            margin: EdgeInsets.only(left: width / 20),
                            child: Center(
                              child: Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Comfortaa',
                                    letterSpacing: 0.3,
                                    color: AppThemes.mainThemes,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 40,
                          ),
                          Container(
                            height: height / 10,
                            width: width,
                            margin: EdgeInsets.only(
                                left: width / 6, right: width / 6),
                            child: Center(
                                child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Start',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),
                                    Text(
                                      '${sdf2.format(DateFormat('Hms').parse(startTime))}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                SizedBox(
                                  width: width / 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'End',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),
                                    Text(
                                      '${sdf2.format(DateFormat('Hms').parse(endTime))}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            )),
                            decoration: BoxDecoration(
                                color: AppThemes.mainThemes,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Container(
                            width: width,
                            margin: EdgeInsets.only(left: width / 20),
                            child: Center(
                              child: Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Comfortaa',
                                    letterSpacing: 0.3,
                                    color: AppThemes.mainThemes,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height / 50,
                          ),
                          Container(
                            height: height / 10,
                            width: width,
                            margin: EdgeInsets.only(
                                left: width / 6, right: width / 6),
                            child: Center(
                                child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Start',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),
                                    Text(
                                      '$startDate',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                SizedBox(
                                  width: width / 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'End',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height / 80,
                                    ),
                                    Text(
                                      '$endDate',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Comfortaa',
                                          letterSpacing: 0.3,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            )),
                            decoration: BoxDecoration(
                                color: AppThemes.mainThemes,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.only(left: width / 20),
                            child: Text(
                              'Requests',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Comfortaa',
                                  letterSpacing: 0.3,
                                  color: AppThemes.mainThemes,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: height / 30,
                          ),
                          widget.edit == 'no'
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    if (widget.mapdata['request'] > 0) {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: ChangeNotifierProvider(
                                                create: (_) =>
                                                    BlockGiverActiveRequest(),
                                                child: GiverActiveRequest(),
                                              )));
                                    }
                                  },
                                  child: Container(
                                    width: width,
                                    height: height / 16,
                                    padding: EdgeInsets.only(
                                        left: width / 20, right: width / 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'You have new requests',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'Comfortaa',
                                              letterSpacing: 0.3,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${widget.mapdata['request']}  ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily: 'Comfortaa',
                                                  letterSpacing: 0.3,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.message,
                                              color: Colors.white,
                                            ),
                                          ],
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                    ),
                                    margin: EdgeInsets.only(
                                        left: width / 20, right: width / 20),
                                    decoration: BoxDecoration(
                                        color: AppThemes.mainThemes,
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 4,
                                              spreadRadius: 2,
                                              color: Colors.black12,
                                              offset: Offset(2, 5))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ),
                          SizedBox(
                            height: height / 30,
                          ),
                          widget.edit == 'no'
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 500),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: ChangeNotifierProvider(
                                              create: (_) =>
                                                  BlockReciverOrderPageHome(),
                                              child: ReciverOrderPageHome(
                                                id: widget.mapdata['id'],
                                                hselist: 'no',
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    width: width,
                                    height: height / 16,
                                    margin: EdgeInsets.only(
                                        left: width / 7, right: width / 7),
                                    child: Center(
                                      child: Text(
                                        'Request',
                                        textAlign: TextAlign.left,
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
                                              blurRadius: 4,
                                              spreadRadius: 2,
                                              color: Colors.black12,
                                              offset: Offset(2, 5))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                )
                              : SizedBox(),
                          widget.edit == 'no'
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 400),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: ChangeNotifierProvider(
                                              create: (_) => BlockFoodUpDate(),
                                              child: UpDateFoodData(
                                                mapData: widget.mapdata,
                                                index: widget.index,
                                                serving: (widget.mapdata[
                                                        'number_of_serving'])
                                                    .toString(),
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    width: width,
                                    height: height / 16,
                                    margin: EdgeInsets.only(
                                        left: width / 7, right: width / 7),
                                    child: Center(
                                      child: Text(
                                        'Edit',
                                        textAlign: TextAlign.left,
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
                                              blurRadius: 4,
                                              spreadRadius: 2,
                                              color: Colors.black12,
                                              offset: Offset(2, 5))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                          SizedBox(
                            height: height / 30,
                          ),
                          widget.edit == 'no'
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    ApiUtilsClass.deleteFood(
                                        context: context,
                                        id: (widget.mapdata['id']).toString(),
                                        mode: widget.mode);
                                    setState(() {
                                      loading = true;
                                    });
                                  },
                                  child: Container(
                                    width: width,
                                    height: height / 16,
                                    margin: EdgeInsets.only(
                                        left: width / 7, right: width / 7),
                                    child: Center(
                                      child: loading == true
                                          ? LocliSpin.spinKit(c: Colors.white)
                                          : Text(
                                              'Delete',
                                              textAlign: TextAlign.left,
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
                                              blurRadius: 4,
                                              spreadRadius: 2,
                                              color: Colors.black12,
                                              offset: Offset(2, 5))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                  padding: EdgeInsets.only(left: width / 20, top: width / 7),
                  child: InkWell(
                    onTap: () {
                      onbackpress(_controller);
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
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
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

  setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
      PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        // create a Polyline instance
        // with an id, an RGB color and the list of LatLng pairs
        Polyline polyline = Polyline(
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates);

        // add the constructed polyline as a set of points
        // to the polyline set, which will eventually
        // end up showing up on the map
        _polylines.add(polyline);
      });
    }
  }
}
