import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SharingOut/GiverDataCalling.dart';
import 'package:SharingOut/Services/In_appPushNotification.dart';
import 'package:SharingOut/main.dart';

class PushNotificationServices {
  FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialize(BuildContext context) async {
    if (Platform.isIOS) {
      _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          log("ios onMessage: $message");
          var data = message;
          log('title = ${data['notification']['title']}');
          log('body = ${data['notification']['body']}');
          InAppPushNotification.inAppnotifi(
              title: '${data['notification']['title']}',
              subTitle: '${data['notification']['body']}',
              id: data['order_id'],
              context: context,
              );
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          MyApp.isLuanch = false;

          navigationService(message,context);
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
          MyApp.isLuanch = false;
          navigationService(message,context);
        },
      );
      _fcm.requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: false));
      _fcm.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    } else {
      _fcm.configure(onMessage: (
          Map<String, dynamic> message,
          ) async {
        log("android onMessage: $message");
        var data = message;
        InAppPushNotification.inAppnotifi(
            title: '${data['notification']['title']}',
            subTitle: '${data['notification']['body']}',
            id: data['data']['order_id'],
            context: context,
            chat: data['data']['chat']);
      }, onLaunch: (Map<String, dynamic> message) async {
        MyApp.isLuanch = false;
        navigationService(message, context);
      }, onResume: (Map<String, dynamic> message) async {
        MyApp.isLuanch = false;
        navigationService(message, context);
      });
    }
  }

  void navigationService(Map<String, dynamic> message, BuildContext context) {
    var data = message;
    if(Platform.isIOS){
      if(data.containsKey('chat')){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => GiverDataCalling(
              userId: data['order_id'],
              chat: data['chat'] == 'true' ? true : false,
            )));
      }else{
        Navigator.of(context).push(MaterialPageRoute(
            builder: (c) => GiverDataCalling(
              userId: data['order_id'],
              chat:false,
            )));
      }

    }else{
      Navigator.of(context).push(MaterialPageRoute(
          builder: (c) => GiverDataCalling(
            userId: data['data']['order_id'],
            chat: data['chat'] == 'true' ? true : false,
          )));
    }

  }
}
