import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';

class CoomingSoonPage extends StatefulWidget {
  CoomingSoonPage({Key key}) : super(key: key);

  @override
  _CoomingSoonPageState createState() => _CoomingSoonPageState();
}

class _CoomingSoonPageState extends State<CoomingSoonPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 250.0,
                  child: ScaleAnimatedTextKit(
                      totalRepeatCount: 100,
                      duration: Duration(seconds: 2),
                      onTap: () {
                        print("Tap Event");
                      },
                      text: ["Coming Soon"],
                      textStyle: TextStyle(
                          fontSize: 50.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          color: AppThemes.mainThemes),
                      textAlign: TextAlign.center,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
              ),
              Center(
                child: AnimatedContainer(
                  height: height / 8,
                  width: width / 2.6,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.fill,
                    color: AppThemes.mainThemes,
                  ),
                  margin: EdgeInsets.only(top: height / 20),
                  duration: Duration(seconds: 1),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
