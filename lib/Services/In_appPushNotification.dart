import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/GiverDataCalling.dart';

class InAppPushNotification {
  static inAppnotifi(
      {String title, String subTitle, id, BuildContext context, chat}) {
    print('chat = $chat');
    Future.delayed(Duration(seconds: 0), () {
      showSimpleNotification(
        Text(
          "$title",
          style: TextStyle(
              fontSize: 11,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        duration: Duration(seconds: 2),
        elevation: 8,
        position: NotificationPosition.top,
        slideDismiss: true,
        subtitle: Text(
          '$subTitle',
          style: TextStyle(
              fontSize: 11,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        background: AppThemes.mainThemes,
        autoDismiss: false,
        trailing: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Text(
                  'Close',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.3,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  OverlaySupportEntry.of(context).dismiss();
                },
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: Text(
                  'View',
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.3,
                      color: Colors.yellow,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  OverlaySupportEntry.of(context).dismiss();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => GiverDataCalling(
                            userId: id,
                            chat: chat == 'true' ? true : false,
                          )));
                },
              ),
            ],
          );
        }),
      );
    });
  }
}
