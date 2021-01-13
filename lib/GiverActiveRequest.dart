import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/GiverModeOrderPageHome.dart';
import 'package:SharingOut/UserDetailPage.dart';
import 'package:SharingOut/provider/BlockGiverActiveRequest.dart';
import 'package:SharingOut/provider/BlockGiverMode.dart';
import 'package:SharingOut/provider/BlockUserDetail.dart';

class GiverActiveRequest extends StatefulWidget {
  GiverActiveRequest({Key key}) : super(key: key);

  @override
  _GiverActiveRequestState createState() => _GiverActiveRequestState();
}

class _GiverActiveRequestState extends State<GiverActiveRequest> {
  @override
  void initState() {
    final BlockGiverActiveRequest _provider =
        Provider.of<BlockGiverActiveRequest>(context, listen: false);
    apiCalling(_provider);
    super.initState();
  }

  apiCalling(BlockGiverActiveRequest provider) async {
    await ApiUtilsClass.activeGiverRequestData(provider);
  }

  @override
  Widget build(BuildContext context) {
    final BlockGiverActiveRequest _provider =
        Provider.of<BlockGiverActiveRequest>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          'Active Requests',
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
        child: _provider.loading == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _provider.searchList.length == 0
                ? Center(
                    child: Text(
                      'No active request',
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
                        onTap: () {},
                        child: AnimatedContainer(
                          height: height / 5,
                          width: width,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            duration:
                                                Duration(milliseconds: 500),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: ChangeNotifierProvider(
                                              create: (_) => BlockGiverMode(),
                                              child: GiverModeOrderPageHome(
                                                list: _provider.searchList[i],
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    height: height / 25,
                                    width: width / 5,
                                    child: Center(
                                      child: Text(
                                        'Active',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Comfortaa',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    margin: EdgeInsets.all(width / 20),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                          errorWidget: (context, url, error) =>
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
                                            color: AppThemes.balckOpacityThemes,
                                            fontFamily: 'Comfortaa',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: height / 100,
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
                                      ),
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  margin: EdgeInsets.all(width / 30),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              duration:
                                                  Duration(milliseconds: 500),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: ChangeNotifierProvider(
                                                create: (_) =>
                                                    BLockUserDetail(),
                                                child: UserDetailPage(
                                                  id: '${_provider.searchList[i]['receiver_id']}',
                                                ),
                                              )));
                                    },
                                    child: Text(
                                      '${_provider.searchList[i]['receiver_name']}',
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
    );
  }
}
