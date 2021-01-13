import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/Authentication/LoginPage.dart';
import 'package:SharingOut/LocalWidget/LocliSpin.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:SharingOut/provider/BlockLogin.dart';
import 'package:SharingOut/provider/BlockSignUp.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool anim = false;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        anim = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlockSignUp _provider = Provider.of<BlockSignUp>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _provider.scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(width / 15),
          height: height,
          width: width,
          child: ListView(
            children: [
              SizedBox(
                height: height / 15,
              ),
              Text(
                'Create Account',
                style: TextStyle(
                    color: AppThemes.mainThemes,
                    fontSize: 35,
                    fontFamily: 'Comfortaa',
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height / 100,
              ),
              Text(
                'Enter your details.',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 13,
                    letterSpacing: 0.5,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: height / 10,
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.ease,
                width: width,
                height: anim == false ? 0 : height / 14,
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
                    controller: _provider.sigUserNameCon,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Full Name',
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
                height: anim == false ? 0 : height / 14,
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
                    controller: _provider.signemailCon,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Email',
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
                height: anim == false ? 0 : height / 14,
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
                    obscureText: true,
                    controller: _provider.signpasswordCon,
                    style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock_open,
                          size: 16,
                          color: AppThemes.mainThemes,
                        ),
                        contentPadding: EdgeInsets.all(width / 40),
                        labelText: 'Password',
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
                height: anim == false ? 0 : height / 14,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    spreadRadius: 2.0,
                    offset: Offset(
                      3.0,
                      5.0,
                    ),
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: width / 20,
                    ),
                    Icon(
                      Icons.phone_iphone,
                      size: 16,
                      color: AppThemes.mainThemes,
                    ),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      '+92',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: 14,
                          letterSpacing: 0.5,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _provider.signPhoneCon,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            color: AppThemes.mainThemes,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(width / 40),
                            hintText: '3331234567',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                                letterSpacing: 0.3,
                                color: Colors.black12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height / 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    if (_provider.sigUserNameCon.text.isNotEmpty &&
                        _provider.signemailCon.text.isNotEmpty &&
                        _provider.signpasswordCon.text.isNotEmpty &&
                        _provider.signPhoneCon.text.isNotEmpty) {
                      _provider.setLoadiing(true);
                      ApiUtilsClass.signCalling(provider: _provider);
                    } else {
                      SnackBars.snackbar(
                          c: Colors.red,
                          text: 'Please Fill up All Fields.',
                          key: _provider.scaffoldKey);
                    }
                  },
                  child: Container(
                    height: height / 18,
                    width: width / 4,
                    child: _provider.loding == false
                        ? Row(
                            children: [
                              Text(
                                'Sign Up',
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
                          )
                        : Center(
                            child: LocliSpin.spinKit(c: Colors.white),
                          ),
                    decoration: BoxDecoration(
                        color: AppThemes.mainThemes,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              SizedBox(
                height: height / 8,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Text(
                      'Already have an account?   ',
                      style: TextStyle(
                          color: Colors.black26,
                          letterSpacing: 0.5,
                          fontSize: 12,
                          fontFamily: 'Comfortaa'),
                    ),
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
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: AppThemes.mainThemes,
                            fontSize: 12,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa'),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
