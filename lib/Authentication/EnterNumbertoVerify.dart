import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';

class EnterNumbertoVerify extends StatefulWidget {
  EnterNumbertoVerify({Key key, this.email, this.password}) : super(key: key);
  final String email;
  final password;
  @override
  _EnterNumbertoVerifyState createState() => _EnterNumbertoVerifyState();
}

class _EnterNumbertoVerifyState extends State<EnterNumbertoVerify> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";

  bool isotp = false;

  final formKey = GlobalKey<FormState>();
  Timer _timer;
  int second = 30;
  void startTimer() {
    const onesec = Duration(seconds: 1);
    _timer = Timer.periodic(onesec, (timer) {
      setState(() {
        if (second < 1) {
          isotp = false;
          second = 30;
          _timer.cancel();
        } else {
          second = second - 1;
          if (isotp == false) {
            isotp = true;
          }
        }
      });
    });
  }
// Timer _timer;
// int _start = 30;

// void startTimer() {
//   const oneSec = const Duration(seconds: 1);
//   _timer = new Timer.periodic(
//     oneSec,
//     (Timer timer) => setState(
//       () {
//         if (_start < 1) {
//           timer.cancel();
//         } else {
//           _start = _start - 1;
//         }
//       },
//     ),
//   );
// }

  @override
  void initState() {
    print('${widget.email}');
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

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
          width: width,
          padding: EdgeInsets.all(width / 20),
          child: ListView(
            children: [
              Container(
                height: height / 2,
                width: width,
                child: Padding(
                  padding: EdgeInsets.all(width / 5),
                  child: Image.asset('assets/otp.png'),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Verify your phone number',
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
                  'Enter your OTP number wich send you on Phone',
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
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      length: 6,
                      obsecureText: false,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(6),

                      ],
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v.length < 3) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor:
                            hasError ? AppThemes.mainThemes : Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (v) {
                        ApiUtilsClass.otpVerificationFinal(
                            '${textEditingController.text}',
                            _scaffoldKey,
                            widget.password);
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: height / 50,
              ),
              InkWell(
                child: Center(
                    child: Text(
                  'Clear Text',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppThemes.mainThemes,
                  ),
                )),
                onTap: () {
                  textEditingController.clear();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Didn\'t receive the code? ',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  InkWell(
                    onTap: () {
                      if (isotp == false) {
                        startTimer();
                        ApiUtilsClass.otpVerification(
                            '${widget.email}', _scaffoldKey, '');
                      }
                    },
                    child: Text(
                        isotp == false ? 'RESEND' : 'Wait 30 seconds = ',
                        style: TextStyle(
                            color: isotp == false
                                ? AppThemes.mainThemes
                                : Colors.black38,
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                  Text(isotp == false ? '' : '00:$second',
                      style: TextStyle(
                          color: AppThemes.mainThemes,
                          fontWeight: FontWeight.w500,
                          fontSize: 14))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
