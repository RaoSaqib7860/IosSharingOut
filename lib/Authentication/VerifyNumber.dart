import 'package:flutter/material.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';

class VerifyNumber extends StatefulWidget {
  VerifyNumber({Key key, this.wich}) : super(key: key);
  final String wich;
  @override
  _VerifyNumberState createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  String wich = 'number';
  bool loading = false;
  TextEditingController emailNameCon = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(width / 20),
          child: ListView(
            children: [
              Container(
                height: height / 2,
                width: width,
                child: Padding(
                  padding: EdgeInsets.all(width / 5),
                  child: Image.asset('assets/verifyim.png'),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Verify your number',
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
                  'Enter your number we will send you OTP to verify',
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
                height: height / 30,
              ),
              // AnimatedContainer(
              //   duration: Duration(milliseconds: 800),
              //   curve: Curves.ease,
              //   width: width,
              //   height: height / 15,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.black12,
              //             blurRadius: 5,
              //             spreadRadius: 2.0,
              //             offset: Offset(
              //               3.0,
              //               5.0,
              //             ),
              //           ),
              //         ],
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(5)),
              //     child: TextFormField(
              //       controller: emailNameCon,
              //       style: TextStyle(color: AppThemes.mainThemes, fontSize: 14),
              //       decoration: InputDecoration(
              //           border: InputBorder.none,
              //           prefixIcon: Icon(
              //             Icons.mail,
              //             size: 16,
              //             color: AppThemes.mainThemes,
              //           ),
              //           contentPadding: EdgeInsets.all(width / 40),
              //           labelText: 'Email',
              //           labelStyle: TextStyle(
              //               fontSize: 11,
              //               fontFamily: 'Comfortaa',
              //               letterSpacing: 0.3,
              //               color: Colors.black38,
              //               fontWeight: FontWeight.w600)),
              //     ),
              //   ),
              // )
              // :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: height / 26,
                      ),
                      Text(
                        '+92',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            letterSpacing: 0.5,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black.withOpacity(0.5),
                        width: width / 13,
                      )
                    ],
                  ),
                  SizedBox(width: width / 15),
                  Container(
                    child: TextFormField(
                      controller: emailNameCon,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          letterSpacing: 0.5,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: '3031234567',
                        contentPadding: EdgeInsets.only(top: height / 30),
                        hintStyle: TextStyle(
                            color: Colors.black26,
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    width: width / 2.5,
                  ),
                ],
              ),
              SizedBox(
                height: height / 20,
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (emailNameCon.text.isNotEmpty) {
                        ApiUtilsClass.requestEmailForResetPasswordFinal(
                            '${emailNameCon.text}', _scaffoldKey, widget.wich);
                      } else {
                        SnackBars.snackbar(
                            c: Colors.red,
                            key: _scaffoldKey,
                            text: 'Please Enter your number');
                      }
                    },
                    child: Container(
                      height: height / 22,
                      width: width / 1.7,
                      decoration: BoxDecoration(
                          color: AppThemes.mainThemes,
                          borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Text(
                          'Send',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.4),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        // if (wich == 'number') {
                        //   setState(() {
                        //     wich = '';
                        //   });
                        // } else {
                        //   setState(() {
                        //     wich = 'number';
                        //   });
                        // }
                      },
                      child: Text(
                        '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppThemes.mainThemes,
                            fontSize: 11,
                            letterSpacing: 0.5,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
