import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/Account.dart';
import 'package:SharingOut/ActiveRequestReciver.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/Authentication/LoginSignUpIntro.dart';
import 'package:SharingOut/GiverActiveRequest.dart';
import 'package:SharingOut/GiverItemRequest.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/HowToUse.dart';
import 'package:SharingOut/ItemRequestedReciver.dart';
import 'package:SharingOut/SharedPrefence/SharedPreference.dart';
import 'package:SharingOut/TersmAndCondition.dart/PrivacyPolicy.dart';
import 'package:SharingOut/TersmAndCondition.dart/TermsAndCondition.dart';
import 'package:SharingOut/provider/BlockAccount.dart';
import 'package:SharingOut/provider/BlockGiverActiveRequest.dart';
import 'package:SharingOut/provider/BlockGiverItemRequested.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockItemRequestedReciver.dart';
import 'package:SharingOut/provider/BlockReciverActiveRequest.dart';

class DrawerLayout extends StatefulWidget {
  DrawerLayout({
    Key key,
    this.mode,
    this.giverActive,
    this.giverCompleted,
    this.reciverActive,
    this.reciverCompleted,
  }) : super(key: key);
  final String mode;
  final giverActive;
  final giverCompleted;
  final reciverActive;
  final reciverCompleted;
  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  String wich = '';
  String profile;
  int giveractive = 0;
  int givercompleted = 0;
  int receiveractive = 0;
  int receivercompleted = 0;
  SharedPreferences prefs;
  @override
  void initState() {
    Future.delayed(Duration(), () async {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        profile = prefs.getString('user_profile');

        givercompleted = widget.giverCompleted -
            int.parse(prefs.getString('giver_completed'));
        receivercompleted = widget.reciverCompleted -
            int.parse(prefs.getString('reciver_Completed'));

        giveractive = widget.giverActive;
        receiveractive = widget.reciverActive;
      });
    });
    wich = widget.mode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                height: height / 3.7,
                width: width,
                padding: EdgeInsets.all(width / 20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppThemes.mainThemes,
                  Colors.black,
                  AppThemes.mainThemes
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Column(
                  children: [
                    SizedBox(
                      height: height / 50,
                    ),
                    Row(
                      children: [
                        Text(
                          wich == 'R' ? 'Rescue Mode' : 'Share Mode',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: wich == 'R' ? true : false,
                          onChanged: (value) {
                            if (widget.mode == 'G') {
                              SharedPreferenceClass.addmode('R');
                              setState(() {
                                wich = 'R';
                              });
                              Future.delayed(Duration(milliseconds: 300), () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 500),
                                      type: PageTransitionType.rightToLeft,
                                      child: ChangeNotifierProvider(
                                        create: (_) => BlockHomePage(),
                                        child: HomePage(
                                          mode: 'R',
                                        ),
                                      )),
                                  ModalRoute.withName('/'),
                                );
                              });
                            } else {
                              SharedPreferenceClass.addmode('G');
                              setState(() {
                                wich = 'G';
                              });
                              Future.delayed(Duration(milliseconds: 200), () {
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
                              });
                            }
                          },
                          activeTrackColor: Colors.blueGrey,
                          activeColor: AppThemes.mainThemes,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      children: [
                        profile != null
                            ? ApiUtilsClass.userProfile == null
                                ? CircularProfileAvatar(
                                    '$profile',
                                    elevation: 10,
                                    radius: height / 22,
                                  )
                                : CircularProfileAvatar(
                                    '${ApiUtilsClass.userProfile}',
                                    elevation: 10,
                                    radius: height / 22,
                                  )
                            : CircularProfileAvatar(
                                '',
                                child: Image.asset(
                                  'assets/avatar.png',
                                  fit: BoxFit.cover,
                                ),
                                elevation: 10,
                                radius: height / 22,
                              ),
                        SizedBox(
                          width: width / 30,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            '${ApiUtilsClass.userName}',
                            minFontSize: 7,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Comfortaa',
                                letterSpacing: 0.3,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(width / 20),
                  child: widget.mode == 'G'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 500),
                                      type: PageTransitionType.rightToLeft,
                                      child: ChangeNotifierProvider(
                                        create: (_) => BlockHomePage(),
                                        child: HomePage(
                                          mode: widget.mode,
                                        ),
                                      )),
                                  ModalRoute.withName('/'),
                                );
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.home,
                                  text: 'Home'),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: HowToUse()));
                                });
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.person,
                                  text: 'How to use'),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            InkWell(
                              onTap: () {
                                print('${prefs.getString('giver_completed')}');
                                SharedPreferenceClass.addgiverCompleted(
                                    '${widget.giverCompleted}');
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: ChangeNotifierProvider(
                                            create: (_) =>
                                                BlockGiverItemRequested(),
                                            child: GiverItemRequest(),
                                          )));
                                });
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.assignment,
                                  text: 'Food Shared'),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            InkWell(
                              onTap: () {
                                SharedPreferenceClass.addgiverActive('0');
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 500),
                                        type: PageTransitionType.rightToLeft,
                                        child: ChangeNotifierProvider(
                                          create: (_) =>
                                              BlockGiverActiveRequest(),
                                          child: GiverActiveRequest(),
                                        )));
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.accessibility_new,
                                  text: 'Active Request'),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: ChangeNotifierProvider(
                                            create: (_) => BlockAccount(),
                                            child: AccountPage(
                                              mode: widget.mode,
                                            ),
                                          )));
                                });
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.person_pin,
                                  text: 'Account'),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            SizedBox(
                              height: height / 80,
                            ),

                            InkWell(
                              child: textwidget('Terms and Condition'),
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: TersAndConditions()));
                                });
                              },
                            ),
                            SizedBox(
                              height: height / 80,
                            ),
                            InkWell(
                              child: textwidget('Privacy Policy'),
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: PrivacyPolicy()));
                                });
                              },
                            ),

                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                      duration: Duration(milliseconds: 500),
                                      type: PageTransitionType.rightToLeft,
                                      child: ChangeNotifierProvider(
                                        create: (_) => BlockHomePage(),
                                        child: HomePage(
                                          mode: widget.mode,
                                        ),
                                      )),
                                  ModalRoute.withName('/'),
                                );
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.home,
                                  text: 'Home'),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: HowToUse()));
                                });
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.person,
                                  text: 'How to use'),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            InkWell(
                              onTap: () {
                                SharedPreferenceClass.addreciverCompleted(
                                    '${widget.reciverCompleted}');
                                print('${widget.reciverCompleted}');
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 500),
                                        type: PageTransitionType.rightToLeft,
                                        child: ChangeNotifierProvider(
                                          create: (_) =>
                                              BlockItemRequestedReciver(),
                                          child: ItemRequestedReciver(),
                                        )));
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.assignment,
                                  text: 'Food Rescued'),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(milliseconds: 500),
                                        type: PageTransitionType.rightToLeft,
                                        child: ChangeNotifierProvider(
                                          create: (_) =>
                                              BlockReciverActiveRequest(),
                                          child: ActiveRequestReciver(),
                                        )));
                                SharedPreferenceClass.addreciverActive('0');
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.accessibility_new,
                                  text: 'Active Requests'),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),


                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: ChangeNotifierProvider(
                                            create: (_) => BlockAccount(),
                                            child: AccountPage(
                                              mode: widget.mode,
                                            ),
                                          )));
                                });
                              },
                              child: actionsWidget(
                                  context: context,
                                  icon: Icons.person_pin,
                                  text: 'Account'),
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            SizedBox(
                              height: height / 40,
                            ),

                            InkWell(
                              child: textwidget('Terms and Condition'),
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: TersAndConditions()));
                                });
                              },
                            ),
                            SizedBox(
                              height: height / 40,
                            ),
                            InkWell(
                              child: textwidget('Privacy Policy'),
                              onTap: () {
                                Navigator.of(context).pop();
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 500),
                                          type: PageTransitionType.rightToLeft,
                                          child: PrivacyPolicy()));
                                });
                              },
                            ),

                          ],
                        ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: InkWell(
            onTap: () {
              exit(0);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: width / 10, left: width / 15),
              child: Text(
                'Exit',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppThemes.mainThemes,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              SharedPreferenceClass.removeValues();
              Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child: LoginSignUpIntroPage()),
                ModalRoute.withName('/'),
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: width / 10, right: width / 15),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppThemes.mainThemes,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget textwidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$text',
          style: TextStyle(
            fontSize: 13,
            color: Colors.black38,
            fontFamily: 'Comfortaa',
          ),
        ),
      ],
    );
  }

  Widget actionsWidget({BuildContext context, IconData icon, String text}) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        text == 'Active Request'
            ? giveractive == 0
                ? Icon(
                    icon,
                    color: AppThemes.balckOpacityThemes,
                  )
                : Badge(
                    badgeContent: Text(
                      '$giveractive',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    child: Icon(
                      icon,
                      color: AppThemes.balckOpacityThemes,
                    ),
                  )
            : text == 'Order Completed'
                ? givercompleted == 0
                    ? Icon(
                        icon,
                        color: AppThemes.balckOpacityThemes,
                      )
                    : Badge(
                        badgeContent: Text(
                          '$givercompleted',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        child: Icon(
                          icon,
                          color: AppThemes.balckOpacityThemes,
                        ),
                      )
                : text == 'Item Requested'
                    ? receivercompleted == 0
                        ? Icon(
                            icon,
                            color: AppThemes.balckOpacityThemes,
                          )
                        : Badge(
                            badgeContent: Text(
                              '$receivercompleted',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                            child: Icon(
                              icon,
                              color: AppThemes.balckOpacityThemes,
                            ),
                          )
                    : text == 'Active Requests'
                        ? receiveractive == 0
                            ? Icon(
                                icon,
                                color: AppThemes.balckOpacityThemes,
                              )
                            : Badge(
                                badgeContent: Text(
                                  '$receiveractive',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                child: Icon(
                                  icon,
                                  color: AppThemes.balckOpacityThemes,
                                ),
                              )
                        : Icon(
                            icon,
                            color: AppThemes.balckOpacityThemes,
                          ),
        SizedBox(
          width: width / 30,
        ),
        Text(
          '$text',
          style: TextStyle(
              color: AppThemes.balckOpacityThemes,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}
