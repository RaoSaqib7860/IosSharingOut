import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/AddFoodData.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/DrawerLayout.dart';
import 'package:SharingOut/FoodDetailPage.dart';
import 'package:SharingOut/NearBySeachPage.dart';
import 'package:SharingOut/provider/BlockAddFood.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockNearbySearch.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:android_intent/android_intent.dart';
import 'LocalWidget/NoconnectionDailog.dart';
import 'Services/InternetConnectivity.dart';

class HomePage extends StatefulWidget {
  static var provider;
  HomePage({Key key, this.mode}) : super(key: key);
  final String mode;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool anim = false;
  SharedPreferences prefs;
  int tabindex = 0;
  LatLng latLng;
  @override
  void initState() {
    internet();
    final BlockHomePage _provider =
        Provider.of<BlockHomePage>(context, listen: false);
    getLocation();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        anim = true;
      });
    });
    getstateCalling(_provider);
    if (widget.mode != 'R') {
      getAPiData(_provider);
    }
    super.initState();
  }

  internet() async {
    await InterNetConnectivity.chekInternetConnection();
    if (InterNetConnectivity.internet == false) {
      NoConnectionDailog.connection(context);
    } else {}
  }

  getstateCalling(BlockHomePage provider) async {
    await ApiUtilsClass.userState(provider);
    await SharedPreferences.getInstance();
    await ApiUtilsClass.getAccountDataforHome(provider);
  }
  Future<void> getLocation() async {
    Position position = await Geolocator.getLastKnownPosition();
    if (position != null) {
      setState(() {
        latLng = LatLng(position.latitude, position.longitude);
        NearBySearchPage.latlng = latLng;
      });
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (position != null) {
        print('latitude is = ${position.latitude}');
        print('longitude is = ${position.longitude}');
        setState(() {
          latLng = LatLng(position.latitude, position.longitude);
          NearBySearchPage.latlng = latLng;
        });
      }
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
                        /*final AndroidIntent intent = AndroidIntent(
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

  getAPiData(BlockHomePage provider) async {
    await ApiUtilsClass.getHomePageData(provider: provider);
  }

  Future onBackPress() async {}

  @override
  Widget build(BuildContext context) {
    final BlockHomePage _provider = Provider.of<BlockHomePage>(context);
    HomePage.provider = _provider;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        key: _provider.scaffoldKey,
        drawer: Drawer(
            child: DrawerLayout(
          giverActive: _provider.giveractive,
          giverCompleted: _provider.giverCompleted,
          reciverActive: _provider.reciveractive,
          reciverCompleted: _provider.reciverRequested,
          mode: widget.mode,
        )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width / 12,
            ),
            widget.mode == 'R'
                ? SizedBox(
                    width: width / 12,
                  )
                : FloatingActionButton(
                    backgroundColor: AppThemes.mainThemes,
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: ChangeNotifierProvider(
                                create: (_) => BlockAddFood(),
                                child: AddFoodData(),
                              )));
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
        backgroundColor: Colors.white,
        appBar: widget.mode == 'R'
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                    icon: Icon(
                      Icons.dehaze,
                      color: AppThemes.balckOpacityThemes,
                    ),
                    onPressed: () {
                      _provider.scaffoldKey.currentState.openDrawer();
                    }),
                automaticallyImplyLeading: false,
                title: Text(
                  'Sharing out',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      color: AppThemes.balckOpacityThemes),
                ),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(height / 15),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                      icon: Icon(
                        Icons.dehaze,
                        color: AppThemes.balckOpacityThemes,
                      ),
                      onPressed: () {
                        _provider.scaffoldKey.currentState.openDrawer();
                      }),
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Sharing out',
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: AppThemes.balckOpacityThemes),
                  ),
                ),
              ),
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(color: Colors.white),
          child: widget.mode == 'R'
              ? ChangeNotifierProvider(
                  create: (_) => BlockNearbySearch(),
                  child: NearBySearchPage(
                    mode: widget.mode,
                  ),
                )
              : DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: TabBar(
                      onTap: (index) {
                        print('$index');
                        setState(() {
                          tabindex = index;
                        });
                      },
                      indicatorColor: AppThemes.mainThemes,
                      tabs: [
                        Tab(
                          child: Text(
                            'Active',
                            style: TextStyle(
                                fontFamily: 'Comfortaa',
                                color: AppThemes.balckOpacityThemes,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'In Active',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Comfortaa',
                                color: AppThemes.balckOpacityThemes,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    body: TabBarView(
                      children: [
                        Container(
                          height: height,
                          width: width,
                          decoration: BoxDecoration(color: Colors.white),
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
                            controller: _provider.activerefreshController,
                            onRefresh: _provider.activeonRefresh,
                            onLoading: _provider.activeonLoading,
                            child: _provider.loading == false
                                ? Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : _provider.activeList.length == 0
                                    ? Center(
                                        child: Text(
                                          'Please first add food !',
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                          ),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemBuilder: (c, i) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      duration: Duration(
                                                          milliseconds: 400),
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: FoodDetailPage(
                                                        mapdata: _provider
                                                            .activeList[i],
                                                        index: '$i',
                                                      )));
                                            },
                                            child: AnimatedOpacity(
                                              duration:
                                                  Duration(milliseconds: 700),
                                              opacity: anim == false ? 0 : 1,
                                              child: AnimatedContainer(
                                                height: height / 5,
                                                width: width,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: width / 20),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                      child: Container(
                                                        height: height / 9,
                                                        width: width / 3,
                                                        child: Hero(
                                                          tag: 'hero_tag+$i',
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                "${_provider.activeList[i]['image']}",
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                CupertinoActivityIndicator(),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
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
                                                            '${_provider.activeList[i]['name']}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: AppThemes
                                                                    .balckOpacityThemes,
                                                                fontFamily:
                                                                    'Comfortaa',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height / 100,
                                                        ),
                                                        SizedBox(
                                                          height: height / 50,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: width / 50,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  size: 15,
                                                                  color: AppThemes
                                                                      .balckOpacityThemes,
                                                                ),
                                                                Text(
                                                                  ' ${_provider.activeList[i]['views']} Views',
                                                                  style: TextStyle(
                                                                      color: AppThemes
                                                                          .balckOpacityThemes,
                                                                      fontFamily:
                                                                          'Comfortaa',
                                                                      fontSize:
                                                                          9),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    )
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                margin: EdgeInsets.only(
                                                    top: anim == false
                                                        ? height / 10
                                                        : height / 100,
                                                    left: width / 20,
                                                    right: width / 20,
                                                    bottom: height / 30),
                                                duration:
                                                    Duration(milliseconds: 700),
                                              ),
                                            ),
                                          );
                                        },
                                        physics: BouncingScrollPhysics(),
                                        itemCount: _provider.activeList.length,
                                        scrollDirection: Axis.vertical,
                                      ),
                          ),
                        ),
                        Container(
                          height: height,
                          width: width,
                          decoration: BoxDecoration(color: Colors.white),
                          margin: EdgeInsets.only(bottom: height / 10),
                          child: SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              header: WaterDropHeader(),
                              footer: CustomFooter(
                                builder:
                                    (BuildContext context, LoadStatus mode) {
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
                              controller: _provider.inactiverefreshController,
                              onRefresh: _provider.inactiveonRefresh,
                              onLoading: _provider.inactiveonLoading,
                              child: _provider.loading == false
                                  ? Center(
                                      child: CupertinoActivityIndicator(),
                                    )
                                  : _provider.inActiveList.length == 0
                                      ? Center(
                                          child: Text(
                                            'Please first add food!',
                                            style: TextStyle(
                                              fontFamily: 'Comfortaa',
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemBuilder: (c, i) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        duration: Duration(
                                                            milliseconds: 400),
                                                        type: PageTransitionType
                                                            .rightToLeft,
                                                        child: FoodDetailPage(
                                                          mapdata: _provider
                                                              .inActiveList[i],
                                                          index: '$i',
                                                        )));
                                              },
                                              child: AnimatedOpacity(
                                                duration:
                                                    Duration(milliseconds: 700),
                                                opacity: anim == false ? 0 : 1,
                                                child: AnimatedContainer(
                                                  height: height / 5,
                                                  width: width,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                          width: width / 20),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        child: Container(
                                                          height: height / 9,
                                                          width: width / 3,
                                                          child: Hero(
                                                            tag: 'hero_tag+$i',
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "${_provider.inActiveList[i]['image']}",
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  CupertinoActivityIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          width: width / 20),
                                                      Column(
                                                        children: [
                                                          SizedBox(
                                                            height: height / 50,
                                                          ),
                                                          Container(
                                                            width: width / 2.5,
                                                            child: Text(
                                                              '${_provider.inActiveList[i]['name']}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: AppThemes
                                                                      .balckOpacityThemes,
                                                                  fontFamily:
                                                                      'Comfortaa',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height / 100,
                                                          ),
                                                          SizedBox(
                                                            height: height / 50,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width / 50,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .remove_red_eye,
                                                                    color: AppThemes
                                                                        .balckOpacityThemes,
                                                                    size: 15,
                                                                  ),
                                                                  Text(
                                                                    ' ${_provider.inActiveList[i]['views']} Views',
                                                                    style: TextStyle(
                                                                        color: AppThemes
                                                                            .balckOpacityThemes,
                                                                        fontFamily:
                                                                            'Comfortaa',
                                                                        fontSize:
                                                                            9),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                      )
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  margin: EdgeInsets.only(
                                                      top: anim == false
                                                          ? height / 10
                                                          : height / 100,
                                                      left: width / 20,
                                                      bottom: height / 30,
                                                      right: width / 20),
                                                  duration: Duration(
                                                      milliseconds: 700),
                                                ),
                                              ),
                                            );
                                          },
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              _provider.inActiveList.length == 0
                                                  ? 0
                                                  : _provider
                                                      .inActiveList.length,
                                          scrollDirection: Axis.vertical,
                                        )),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
