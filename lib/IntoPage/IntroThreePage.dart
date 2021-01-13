import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:SharingOut/HomePage.dart';

class IntroThree extends StatefulWidget {
  IntroThree({Key key}) : super(key: key);

  @override
  _IntroThreeState createState() => _IntroThreeState();
}

class _IntroThreeState extends State<IntroThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: HomePage(),
                    ));
              },
              child: Container(
                height: 30,
                width: 60,
                child: Center(
                  child: Text('Skip'),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.all(30),
              ),
            ),
          )
        ],
      ),
    );
  }
}
