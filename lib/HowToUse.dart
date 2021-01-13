import 'dart:io';

import 'package:flutter/material.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';

class HowToUse extends StatefulWidget {
  HowToUse({Key key}) : super(key: key);

  @override
  _HowToUseState createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  List boolian = [false, false, false, false, false];
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: scaffoldkey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(
              top: width / 12, left: width / 10, right: width / 10),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Simple steps to rescue food',
                  style: TextStyle(
                      color: AppThemes.mainThemes,
                      fontSize: 18,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              InkWell(
                child: titleHeader('Decide what to share', 0),
                onTap: () {
                  if (boolian[0] == false) {
                    setState(() {
                      boolian[0] = true;
                    });
                  } else {
                    setState(() {
                      boolian[0] = false;
                    });
                  }
                },
              ),
              boolian[0] == false
                  ? Container()
                  : text(
                      'Anything edible, cooked/ uncooked or raw, leftover/ surplus or opened/ unopened.'),
              InkWell(
                child: titleHeader('List it on the app', 1),
                onTap: () {
                  if (boolian[1] == false) {
                    setState(() {
                      boolian[1] = true;
                    });
                  } else {
                    setState(() {
                      boolian[1] = false;
                    });
                  }
                },
              ),
              boolian[1] == false
                  ? Container()
                  : text(
                      'Take a picture, add details and set a pickup location. This can be your home, work or public location.'),
              InkWell(
                child: titleHeader('Get verified ', 2),
                onTap: () {
                  if (boolian[2] == false) {
                    setState(() {
                      boolian[2] = true;
                    });
                  } else {
                    setState(() {
                      boolian[2] = false;
                    });
                  }
                },
              ),
              boolian[2] == false
                  ? Container()
                  : text(
                      'To share on Sharing Out needs to be phone verified. You will be sent a code via SMS when you add your food.'),
              InkWell(
                child: titleHeader('Choose who to share with ', 3),
                onTap: () {
                  if (boolian[3] == false) {
                    setState(() {
                      boolian[3] = true;
                    });
                  } else {
                    setState(() {
                      boolian[3] = false;
                    });
                  }
                },
              ),
              boolian[3] == false
                  ? Container()
                  : text(
                      'You may receive multiple rescue requests, so check out user profile and ratings to finalise the rescuer.Once sharing is agreed, share exact pickup address'),
              InkWell(
                child: titleHeader('Feel like a hero ', 4),
                onTap: () {
                  if (boolian[4] == false) {
                    setState(() {
                      boolian[4] = true;
                    });
                  } else {
                    setState(() {
                      boolian[4] = false;
                    });
                  }
                },
              ),
              boolian[4] == false
                  ? Container()
                  : text(
                      'Feel like hero knowing you’ve helped save resources, the planet and made a neighbour’s day!')
            ],
          ),
        ));
  }

  Widget text(String title) {
    return Text(
      '$title',
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black38,
        fontSize: 14,
        fontFamily: 'Comfortaa',
      ),
    );
  }

  Widget titleHeader(String title, int index) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height / 15,
      child: Row(children: [
        Container(
          width: width / 1.8,
          child: Text(
            '$title',
            style: TextStyle(
                color: AppThemes.balckOpacityThemes,
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold),
          ),
        ),
        Icon(
          boolian[index] == false ? Icons.add : Icons.minimize,
          color: AppThemes.balckOpacityThemes,
        ),
      ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
    );
  }
}
