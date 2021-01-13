import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/Authentication/LoginPage.dart';
import 'package:SharingOut/Authentication/SignUpPage.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockLogin.dart';
import 'package:SharingOut/provider/BlockSignUp.dart';

class LoginSignUpIntroPage extends StatefulWidget {
  LoginSignUpIntroPage({Key key}) : super(key: key);

  @override
  _LoginSignUpIntroPageState createState() => _LoginSignUpIntroPageState();
}

class _LoginSignUpIntroPageState extends State<LoginSignUpIntroPage> {
  bool anim = false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  Future onbackpress() async {}
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onbackpress(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: height,
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height / 10,
                ),
                Text(
                  'Welcome',
                  style: TextStyle(
                      color: AppThemes.mainThemes,
                      fontSize: 40,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'LET\'s FIGHT FOOD WASTE TOGETHER .',
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: 10,
                      letterSpacing: 0.5,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height / 25),
                Container(
                  height: height / 2,
                  width: width,
                  padding: EdgeInsets.all(width / 15),
                  child: Image.asset(
                    'assets/introo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height / 25),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String token = prefs.getString('user_token');
                    int userID = prefs.getInt('user_id');
                    if (token != null) {
                      ApiUtilsClass.token = token;
                      ApiUtilsClass.userId = userID;
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
                  },
                  child: AnimatedContainer(
                    height: height / 17,
                    width: anim == false ? 0 : width / 1.5,
                    duration: Duration(milliseconds: 800),
                    curve: Curves.ease,
                    child: Center(
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.4),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: AppThemes.mainThemes,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
                SizedBox(height: height / 50),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: ChangeNotifierProvider(
                              create: (_) => BlockSignUp(),
                              child: SignUpPage(),
                            )));
                  },
                  child: AnimatedContainer(
                    height: height / 17,
                    width: anim == false ? 0 : width / 1.5,
                    curve: Curves.ease,
                    child: Center(
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            color: AppThemes.mainThemes,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.4),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppThemes.mainThemes,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(40)),
                    duration: Duration(milliseconds: 800),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
