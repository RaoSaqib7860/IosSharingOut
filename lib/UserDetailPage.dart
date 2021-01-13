import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/provider/BlockUserDetail.dart';
import 'package:intl/intl.dart';
import 'AppThemes/AppThemes.dart';

class UserDetailPage extends StatefulWidget {
  UserDetailPage({Key key, this.id}) : super(key: key);
  final id;
  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  List starList = [1, 2, 3, 4, 5];
  DateFormat sdf2 = DateFormat("hh.mm aa");
  @override
  void initState() {
    print('${widget.id}');
    final BLockUserDetail _provider =
        Provider.of<BLockUserDetail>(context, listen: false);
    apiCalling(_provider);
    super.initState();
  }

  apiCalling(BLockUserDetail provider) async {
    await ApiUtilsClass.userDetail(provider, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final BLockUserDetail _provider = Provider.of<BLockUserDetail>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Text(
            'Detail',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: AppThemes.balckOpacityThemes),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(width / 10),
        child: _provider.loding == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Center(
                    child: CircularProfileAvatar(
                      '${_provider.maindata['profile_picture']}',
                      elevation: 10,
                      radius: height / 15,
                    ),
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Row(
                    children: [
                      Text(
                        'Rating : ',
                        style: TextStyle(
                            color: AppThemes.balckOpacityThemes,
                            fontSize: 12,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        children: starList.map((e) {
                          int index = starList.indexOf(e);
                          return Icon(
                            starList[index] <= _provider.maindata['ratings'][0]
                                ? Icons.star
                                : Icons.star_border,
                            color: AppThemes.darkYeloow,
                            size: 15,
                          );
                        }).toList(),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: height / 60,
                  ),
                  Row(
                    children: [
                      Text(
                        'Reviews : ${_provider.maindata['ratings'][1]}',
                        style: TextStyle(
                            color: AppThemes.balckOpacityThemes,
                            fontSize: 12,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
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
                    '${_provider.maindata['name']}',
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
                  SizedBox(
                    height: height / 30,
                  ),
                  Text(
                    'statement',
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
                    '${_provider.maindata['statement']}',
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
                    'created at',
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
                    '${(_provider.maindata['created_at']).toString().substring(0, 10)}   ${sdf2.format(DateFormat('Hms').parse((_provider.maindata['created_at']).toString().substring(11, 19)))}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                        color: Colors.black45),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
      ),
    );
  }
}
