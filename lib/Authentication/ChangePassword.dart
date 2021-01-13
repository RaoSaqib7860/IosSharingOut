import 'package:flutter/material.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key key, this.otp}) : super(key: key);
  final String otp;
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController p1Con = TextEditingController();
  TextEditingController p2Con = TextEditingController();
  TextEditingController p3Con = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        body: Container(
          height: height,
          padding: EdgeInsets.all(width / 15),
          width: width,
          child: ListView(
            children: [
              SizedBox(
                height: height / 20,
              ),
              Text(
                'Password reset',
                style: TextStyle(
                    color: AppThemes.mainThemes,
                    fontSize: 30,
                    fontFamily: 'Comfortaa',
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height / 80,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please enter your new password.',
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
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
                width: width,
                height: height / 12,
                child: Container(
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
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: p1Con,
                    obscureText: true,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'password',
                        labelStyle: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
                width: width,
                height: height / 15,
                child: Container(
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
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: p2Con,
                    obscureText: true,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Re_password',
                        labelStyle: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
                width: width,
                height: height / 15,
                child: Container(
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
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    controller: p3Con,
                    obscureText: true,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Enter OTP',
                        labelStyle: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Comfortaa',
                            letterSpacing: 0.3,
                            color: Colors.black38,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (p1Con.text.isNotEmpty && p2Con.text.isNotEmpty) {
                        if (p1Con.text == p2Con.text) {
                          ApiUtilsClass.forgotPassword(
                              p1Con.text, _scaffoldKey, p3Con.text);
                        } else {
                          SnackBars.snackbar(
                              c: Colors.red,
                              key: _scaffoldKey,
                              text: 'Password didNot match');
                        }
                      } else {
                        SnackBars.snackbar(
                            c: Colors.red,
                            key: _scaffoldKey,
                            text: 'Fields is Empty');
                      }
                    },
                    child: Container(
                      height: height / 18,
                      width: width / 3.5,
                      child: Row(
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Comfortaa',
                                letterSpacing: 0.3,
                                fontSize: 12),
                          ),
                          SizedBox(width: width / 100),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      decoration: BoxDecoration(
                          color: AppThemes.mainThemes,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
