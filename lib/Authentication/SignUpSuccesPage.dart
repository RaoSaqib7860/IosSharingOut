import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/Authentication/LoginPage.dart';
import 'package:SharingOut/provider/BlockLogin.dart';

class SignUpSucsessPage extends StatefulWidget {
  SignUpSucsessPage({Key key}) : super(key: key);

  @override
  _SignUpSucsessPageState createState() => _SignUpSucsessPageState();
}

class _SignUpSucsessPageState extends State<SignUpSucsessPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: ListView(
          children: [
            Container(
              height: height / 2,
              width: width,
              child: Padding(
                padding: EdgeInsets.all(width / 5),
                child: Image.asset('assets/succsesSignUp.png'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'VERIFIED',
                style: TextStyle(
                    color: AppThemes.mainThemes,
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height / 30,
            ),
            Center(
              child: Text(
                'Your number has been successfully verified',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: height / 20,
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(milliseconds: 500),
                            type: PageTransitionType.rightToLeft,
                            child: ChangeNotifierProvider(
                              create: (_) => BlockLogin(),
                              child: LoginPage(),
                            )));
                  },
                  child: Container(
                    height: height / 22,
                    width: width / 1.5,
                    decoration: BoxDecoration(
                        color: AppThemes.mainThemes,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        'GO TO LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
