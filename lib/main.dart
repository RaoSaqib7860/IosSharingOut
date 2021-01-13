import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/Authentication/LoginPage.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/Services/PushNotificationServices.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool isLuanch = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Sharing Out',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Sharing Out'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool anim = false;

  FirebaseMessaging _fcm = FirebaseMessaging();
  final PushNotificationServices _pushNotificationServices =
  PushNotificationServices();

  @override
  void initState() {
    handleNotificatio();
    _fcm.getToken().then((value) => {
      print('fcm token is = $value'),
      ApiUtilsClass.firebaseToken = value});
    _getId().then((value) => {
      ApiUtilsClass.deviceId = value,
    });
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        anim = true;
      });
    });
    Future.delayed(Duration(seconds: 3), () async {
      if (MyApp.isLuanch == true) {
        MyApp.isLuanch = false;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString('user_token');
        int userID = prefs.getInt('user_id');
        String email = prefs.getString('user_email');
        String name = prefs.getString('user_name');
        String phone = prefs.getString('user_phone');
        if (token != null) {
          ApiUtilsClass.token = token;
          ApiUtilsClass.userId = userID;
          ApiUtilsClass.userName = name;
          ApiUtilsClass.userEmail = email;
          ApiUtilsClass.userPhone = phone;
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockHomePage(),
                    child: HomePage(
                      mode: prefs.getString('mode'),
                    ),
                  )));
        } else {
          Navigator.push(
              context,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockLogin(),
                    child: LoginPage(),
                  )));
        }
      }
    });
    super.initState();
  }

  Future handleNotificatio() async {
    await _pushNotificationServices.initialize(context);
  }

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppThemes.mainThemes,
      body: Container(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: anim == false ? 0 : 1,
                  child: AnimatedContainer(
                    height: height / 5.5,
                    width: width / 2.5,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.fill,
                    ),
                    margin: EdgeInsets.only(
                        top: anim == false ? height / 10 : height / 2.5),
                    duration: Duration(seconds: 1),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
