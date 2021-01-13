import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoConnectionDailog {
  static connection(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
                height: 100,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 10,
                    ),
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Text(
                      'No Connection',
                      style: TextStyle(color: Colors.black26),
                    )
                  ],
                )),
          );
        });
  }
}
