import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/SharedPrefence/SharedPreference.dart';
import 'package:SharingOut/UserDetailPage.dart';
import 'package:SharingOut/provider/BlockGiverItemRequested.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockUserDetail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GiverItemRequest extends StatefulWidget {
  static var provider;
  GiverItemRequest({Key key, this.wich}) : super(key: key);
  final String wich;
  @override
  _GiverItemRequestState createState() => _GiverItemRequestState();
}

class _GiverItemRequestState extends State<GiverItemRequest> {
  List list = [1, 2, 3, 4, 5];

  @override
  void initState() {
    final BlockGiverItemRequested _provider =
        Provider.of<BlockGiverItemRequested>(context, listen: false);
    apiCalling(_provider);
    super.initState();
  }

  apiCalling(BlockGiverItemRequested provider) async {
    await ApiUtilsClass.itemRequestedGiverData(provider);
  }

  Future onBackPress() async {
    if (widget.wich == 'ok') {
      SharedPreferenceClass.addmode('G');
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            duration: Duration(milliseconds: 500),
            type: PageTransitionType.rightToLeft,
            child: ChangeNotifierProvider(
              create: (_) => BlockHomePage(),
              child: HomePage(
                mode: 'G',
              ),
            )),
        ModalRoute.withName('/'),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  List ratingList = [1, 2, 3, 4, 5];
  List boolList = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final BlockGiverItemRequested _provider =
        Provider.of<BlockGiverItemRequested>(context);
    GiverItemRequest.provider = _provider;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppThemes.balckOpacityThemes,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          automaticallyImplyLeading: false,
          title: Text(
            'Food Shared',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: AppThemes.balckOpacityThemes),
          ),
        ),
        body: Container(
          height: height,
          width: width,
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
                    child: CircularProgressIndicator(),
                  )
                : _provider.searchList.length == 0
                    ? Center(
                        child: Text(
                          'Request not available',
                          style: TextStyle(
                              color: AppThemes.balckOpacityThemes,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.5),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (c, i) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     PageTransition(
                              //         duration: Duration(milliseconds: 900),
                              //         type: PageTransitionType.rightToLeft,
                              //         child: FoodDetailPage(
                              //           mapdata: _provider.activeList[i],
                              //           index: '$i',
                              //         )));
                            },
                            child: AnimatedContainer(
                              height: height / 5,
                              width: width,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _provider.searchList[i]
                                                    ['giver_rated'] ==
                                                true
                                            ? Container()
                                            : InkWell(
                                                onTap: () {
                                                  for (var i = 0;
                                                      i < list.length;
                                                      i++) {
                                                    boolList[i] = false;
                                                  }
                                                  openDailog(
                                                      i,
                                                      _provider,
                                                      _provider.searchList[i]
                                                          ['order_id'],
                                                      '${_provider.searchList[i]['receiver_name']}');
                                                },
                                                child: Container(
                                                  height: height / 25,
                                                  width: width / 5,
                                                  child: Center(
                                                    child: Text(
                                                      'Add Rating',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Comfortaa',
                                                          fontSize: 9,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      top: width / 20),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppThemes.mainThemes,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                              ),
                                        Container(
                                          height: height / 25,
                                          width: width / 5,
                                          child: Center(
                                            child: Text(
                                              _provider.searchList[i][
                                                          'delivery_accepted'] ==
                                                      false
                                                  ? _provider.searchList[i]
                                                              ['cancelled'] ==
                                                          false
                                                      ? 'Rejected'
                                                      : 'cancelled'
                                                  : 'Completed',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Comfortaa',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              left: width / 40,
                                              right: width / 20,
                                              top: width / 20),
                                          decoration: BoxDecoration(
                                              color: _provider.searchList[i][
                                                          'delivery_accepted'] ==
                                                      false
                                                  ? _provider.searchList[i]
                                                              ['cancelled'] ==
                                                          false
                                                      ? Colors.red
                                                      : Colors.black
                                                  : Colors.green
                                                      .withOpacity(0.6),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: width / 20),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: Container(
                                          height: height / 9,
                                          width: width / 3,
                                          child: Hero(
                                            tag: 'hero_tag+$i',
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "${_provider.searchList[i]['food']['image']}",
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
                                      SizedBox(width: width / 20),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: height / 50,
                                          ),
                                          Text(
                                            '${_provider.searchList[i]['food']['name']}',
                                            style: TextStyle(
                                                color: AppThemes
                                                    .balckOpacityThemes,
                                                fontFamily: 'Comfortaa',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: height / 70,
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
                                                    ' ${_provider.searchList[i]['food']['views']} Views',
                                                    style: TextStyle(
                                                        color: AppThemes
                                                            .balckOpacityThemes,
                                                        fontFamily: 'Comfortaa',
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                  ),
                                  _provider.searchList[i]['completed'] == true
                                      ? Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            margin: EdgeInsets.all(width / 30),
                                            child: InkWell(
                                              onTap: () {
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
                                                              BLockUserDetail(),
                                                          child: UserDetailPage(
                                                            id: _provider.searchList[
                                                                            i][
                                                                        'cancelledby'] ==
                                                                    'giver'
                                                                ? '${_provider.searchList[i]['giver_id']}'
                                                                : '${_provider.searchList[i]['receiver_id']}',
                                                          ),
                                                        )));
                                              },
                                              child: Text(
                                                'Delivered to : ${_provider.searchList[i]['receiver_name']}',
                                                style: TextStyle(
                                                    color: AppThemes.mainThemes,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 9),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            margin: EdgeInsets.all(width / 30),
                                            child: InkWell(
                                              onTap: () {
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
                                                              BLockUserDetail(),
                                                          child: UserDetailPage(
                                                            id: _provider.searchList[
                                                                            i][
                                                                        'cancelledby'] ==
                                                                    'giver'
                                                                ? '${_provider.searchList[i]['giver_id']}'
                                                                : '${_provider.searchList[i]['receiver_id']}',
                                                          ),
                                                        )));
                                              },
                                              child: Text(
                                                'Cancelled by : ${_provider.searchList[i]['cancelledby_name']}',
                                                style: TextStyle(
                                                    color: AppThemes.mainThemes,
                                                    fontFamily: 'Comfortaa',
                                                    fontSize: 9),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft),
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(
                                  top: height / 40,
                                  left: width / 20,
                                  right: width / 20),
                              duration: Duration(milliseconds: 700),
                            ),
                          );
                        },
                        itemCount: _provider.searchList.length,
                      ),
          ),
        ),
      ),
    );
  }

  openDailog(
      int index, BlockGiverItemRequested provider, orderid, String name) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int value = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                height: height / 2.3,
                width: width,
                padding: EdgeInsets.all(width / 20),
                child: Column(
                  children: [
                    Text(
                      'Detail',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                          color: AppThemes.balckOpacityThemes),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                          color: AppThemes.balckOpacityThemes),
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    Text(
                      '$name',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                          color: Colors.black45),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Text(
                      'Please add Rating.',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.4,
                          color: AppThemes.balckOpacityThemes),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: ratingList.map((e) {
                        int index = ratingList.indexOf(e);
                        return Padding(
                          padding: EdgeInsets.only(left: width / 30),
                          child: InkWell(
                            onTap: () {
                              for (var j = 0; j < boolList.length; j++) {
                                setState(() {
                                  boolList[j] = false;
                                });
                              }
                              for (var i = 0; i < index + 1; i++) {
                                setState(() {
                                  boolList[i] = true;
                                });
                              }
                              value = index + 1;
                            },
                            child: boolList[index] == true
                                ? Icon(
                                    Icons.star,
                                    size: 30,
                                    color: AppThemes.darkYeloow,
                                  )
                                : Icon(
                                    Icons.star_border,
                                    size: 30,
                                    color: Colors.black12,
                                  ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (value > 0) {
                            provider.setListRating(index);
                            ApiUtilsClass.addGiverRating(
                                provider, value, '$orderid');
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          height: height / 24,
                          width: width / 5,
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.4,
                                  color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: AppThemes.mainThemes,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
