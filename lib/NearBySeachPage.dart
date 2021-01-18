import 'dart:io';
import 'package:android_intent/android_intent.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/FoodDetailPage.dart';
import 'package:SharingOut/ReciverOrderPageHome.dart';
import 'package:SharingOut/UserDetailPage.dart';
import 'package:SharingOut/provider/BlockNearbySearch.dart';
import 'package:SharingOut/provider/BlockReciverOrderPageHome.dart';
import 'package:SharingOut/provider/BlockUserDetail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NearBySearchPage extends StatefulWidget {
  static var provider;
  static LatLng latlng;
  NearBySearchPage({Key key, this.mode}) : super(key: key);
  final String mode;
  @override
  _NearBySearchPageState createState() => _NearBySearchPageState();
}

class _NearBySearchPageState extends State<NearBySearchPage> {
  bool editTextAvailabilty = false;
  LatLng latLng;
  int kmindex = 7;
  bool anim = false;
  List listKm = ['1', '2', '3', '4', '5', '10', '20'];
  Future<void> getLocation(BlockNearbySearch provider) async {
    Position position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      provider.setloadinglt(true);
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
        NearBySearchPage.latlng = latLng;
      });
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null) {
        provider.setloadinglt(true);
        print('latitude is = ${position.latitude}');
        print('longitude is = ${position.longitude}');
        setState(() {
          latLng = LatLng(position.latitude, position.longitude);
          NearBySearchPage.latlng = latLng;
        });
      }
    }

  }

  String times;
  @override
  void initState() {
    final BlockNearbySearch _provider =
    Provider.of<BlockNearbySearch>(context, listen: false);
    _gpsService();
    getLocation(_provider);
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
      if (Platform.isAndroid) {
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

  @override
  Widget build(BuildContext context) {
    final BlockNearbySearch _provider = Provider.of<BlockNearbySearch>(context);
    NearBySearchPage.provider = _provider;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return _provider.loadinglt == false
        ? Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    )
        : Scaffold(
      key: _provider.scaffoldKey,
      backgroundColor: Colors.white,
      appBar: widget.mode == 'R'
          ? PreferredSize(
        preferredSize: Size.fromHeight(height / 8),
        child: AppBar(
          flexibleSpace: Container(
            height: height / 6,
            child: Column(
              children: [
                SizedBox(
                  height: height / 50,
                ),
                Center(
                  child: Text(
                    'Select Nearby KM',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: AppThemes.balckOpacityThemes),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: width / 9, right: width / 9),
                  child: Row(
                    children: listKm.map((data) {
                      int index = listKm.indexOf(data);
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print('$data');
                              int index = listKm.indexOf(data);
                              setState(() {
                                kmindex = index;
                              });
                              if (index == 5) {
                                _provider.setKm(10);
                              } else if (index == 6) {
                                _provider.setKm(20);
                              } else {
                                _provider.setKm(index + 1);
                              }
                              _provider.setloading(false);
                              ApiUtilsClass.searchFoodCallings(
                                  latLng, _provider);
                            },
                            child: Container(
                              height: height / 20,
                              width: width / 20,
                              decoration: BoxDecoration(
                                  color: kmindex == index
                                      ? AppThemes.mainThemes
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppThemes.mainThemes,
                                      width: 2)),
                            ),
                          ),
                          Text(
                            '$data',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                                color:
                                AppThemes.balckOpacityThemes),
                          ),
                        ],
                      );
                    }).toList(),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
      )
          : PreferredSize(
        preferredSize: Size.fromHeight(height / 4),
        child: AppBar(
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: height / 10),
            height: height / 6,
            child: Column(
              children: [
                SizedBox(
                  height: height / 50,
                ),
                Center(
                  child: Text(
                    'Select Nearby KM',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: AppThemes.balckOpacityThemes),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: width / 9, right: width / 9),
                  child: Row(
                    children: listKm.map((data) {
                      int index = listKm.indexOf(data);
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print('$data');
                              int index = listKm.indexOf(data);
                              setState(() {
                                kmindex = index;
                              });
                              if (index == 5) {
                                _provider.setKm(10);
                              } else if (index == 6) {
                                _provider.setKm(20);
                              } else {
                                _provider.setKm(index + 1);
                              }

                              _provider.setloading(false);
                              ApiUtilsClass.searchFoodCallings(
                                  latLng, _provider);
                            },
                            child: Container(
                              height: height / 20,
                              width: width / 20,
                              decoration: BoxDecoration(
                                  color: kmindex == index
                                      ? AppThemes.mainThemes
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppThemes.mainThemes,
                                      width: 2)),
                            ),
                          ),
                          Text(
                            '$data',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                                color:
                                AppThemes.balckOpacityThemes),
                          ),
                        ],
                      );
                    }).toList(),
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Nearby Food',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: AppThemes.balckOpacityThemes),
          ),
          actions: <Widget>[
            Icon(
              Icons.shopping_cart,
              color: AppThemes.balckOpacityThemes,
            ),
            SizedBox(
              width: width / 20,
            ),
          ],
        ),
      ),
      body: Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("");
              } else {
                body = Text("");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _provider.refreshController,
          onRefresh: _provider.onRefresh,
          onLoading: _provider.onLoading,
          child: _provider.loading == false
              ? Center(
            child: CupertinoActivityIndicator(),
          )
              : _provider.searchList.length == 0
              ? Center(
            child: Text(
              '${_provider.loadingtext}',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: AppThemes.balckOpacityThemes),
            ),
          )
              : ListView.builder(
            itemBuilder: (c, i) {
              String per=(_provider.searchList[i]['distance']).toString();
              return AnimatedContainer(
                height: height / 5,
                width: width,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if (_provider.searchList[i]
                          ['number_of_serving'] >
                              0) {
                            Navigator.push(
                                context,
                                PageTransition(
                                    duration: Duration(
                                        milliseconds: 500),
                                    type: PageTransitionType
                                        .rightToLeft,
                                    child:
                                    ChangeNotifierProvider(
                                      create: (_) =>
                                          BlockReciverOrderPageHome(),
                                      child:
                                      ReciverOrderPageHome(
                                        id: _provider
                                            .searchList[i]
                                        ['id'],
                                        hselist: 'no',
                                      ),
                                    )));
                          }
                        },
                        child: Container(
                          height: height / 25,
                          width: width / 5,
                          child: Center(
                            child: Text(
                              'Request',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          margin: EdgeInsets.only(
                              right: width / 40,
                              top: height / 100),
                          decoration: BoxDecoration(
                              color: AppThemes.mainThemes,
                              borderRadius:
                              BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: width / 20),
                        InkWell(
                          onTap: () {
                            if (_provider.searchList[i]
                            ['number_of_serving'] >
                                0) {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      duration: Duration(
                                          milliseconds: 400),
                                      type: PageTransitionType
                                          .rightToLeft,
                                      child: FoodDetailPage(
                                        mapdata: _provider
                                            .searchList[i],
                                        index: '$i',
                                        edit: 'no',
                                        mode: widget.mode,
                                      )));
                            }
                          },
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(7),
                            child: Container(
                              height: height / 9,
                              width: width / 3,
                              child: Hero(
                                tag: 'hero_tag+$i',
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "${_provider.searchList[i]['image']}",
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
                        ),
                        SizedBox(width: width / 20),
                        Column(
                          children: [
                            SizedBox(
                              height: height / 50,
                            ),
                            Container(
                              width: width / 2.5,
                              child: Text(
                                "${_provider.searchList[i]['name']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppThemes
                                        .balckOpacityThemes,
                                    fontFamily: 'Comfortaa',
                                    fontSize: 14,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            InkWell(
                              onTap: () {
                                if (_provider.searchList[i]
                                ['number_of_serving'] >
                                    0) {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(
                                              milliseconds:
                                              500),
                                          type:
                                          PageTransitionType
                                              .rightToLeft,
                                          child:
                                          ChangeNotifierProvider(
                                            create: (_) =>
                                                BLockUserDetail(),
                                            child:
                                            UserDetailPage(
                                              id: '${_provider.searchList[i]['giver_id']}',
                                            ),
                                          )));
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  CircularProfileAvatar(
                                    '${_provider.searchList[i]['profile_picture']}',
                                    elevation: 6,
                                    radius: height / 60,
                                  ),
                                  SizedBox(
                                    width: width / 30,
                                  ),
                                  SizedBox(
                                    width: width / 3,
                                    child: Text(
                                      '${_provider.searchList[i]['giver_name']}',
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppThemes
                                            .balckOpacityThemes,
                                        fontFamily: 'Comfortaa',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye,
                                      size: 15,
                                      color: AppThemes
                                          .balckOpacityThemes,
                                    ),
                                    Text(
                                      ' ${_provider.searchList[i]['views']} Views',
                                      style: TextStyle(
                                          color: AppThemes
                                              .balckOpacityThemes,
                                          fontFamily:
                                          'Comfortaa',
                                          fontSize: 9),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width / 50,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 15,
                                      color: AppThemes
                                          .balckOpacityThemes,
                                    ),
                                    Text(
                                      '${double.parse(per).toStringAsFixed(2)} KM',
                                      style: TextStyle(
                                          color: AppThemes
                                              .balckOpacityThemes,
                                          fontFamily:
                                          'Comfortaa',
                                          fontSize: 9),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                        )
                      ],
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                    ),
                    _provider.searchList[i]
                    ['number_of_serving'] >
                        0
                        ? Container()
                        : Container(
                      height: height / 4,
                      width: width,
                      child: Center(
                        child: Text(
                          'Served',
                          style: TextStyle(
                              color: AppThemes.mainThemes,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comfortaa',
                              fontSize: 18),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.8)),
                    )
                  ],
                ),
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
                    gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          AppThemes.mainThemes,
                          Colors.white
                        ],
                        begin: _provider.anim == true
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        end: _provider.anim == true
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.only(
                    top: height / 100,
                    bottom: height / 50,
                    left: width / 20,
                    right: width / 20),
                duration: Duration(milliseconds: 1000),
              );
            },
            physics: BouncingScrollPhysics(),
            itemCount: _provider.searchList.length,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }
}
