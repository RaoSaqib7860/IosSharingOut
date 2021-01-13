import 'dart:convert';
import 'dart:io';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/provider/BLockWebScocket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebScocket extends StatefulWidget {
  WebScocket({Key key, this.id, this.name, this.idss, this.notification})
      : super(key: key);
  final int id;
  final name;
  final idss;
  final bool notification;
  @override
  _WebScocketState createState() => _WebScocketState();
}

class _WebScocketState extends State<WebScocket> {
  @override
  void initState() {
    final BlockWebScocket _provider =
        Provider.of<BlockWebScocket>(context, listen: false);
    getapiCalling(_provider);
    super.initState();
  }

  getapiCalling(BlockWebScocket provider) async {
    await ApiUtilsClass.getWebScocketSms(provider, widget.id);
    await ApiUtilsClass.userDetailforChat(provider, '${widget.idss}');
  }

  String sms = '-1';
  final WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse('${ApiUtilsClass.wsbaseUrl}/ws?token=${ApiUtilsClass.token}'));
  Future onbackpress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.notification == true) {
      channel.sink.close();
      Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            duration: Duration(milliseconds: 500),
            type: PageTransitionType.rightToLeft,
            child: ChangeNotifierProvider(
              create: (_) => BlockHomePage(),
              child: HomePage(
                mode: prefs.getString('mode'),
              ),
            )),
        ModalRoute.withName('/'),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final BlockWebScocket _provider = Provider.of<BlockWebScocket>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => onbackpress(),
      child: Scaffold(
        backgroundColor: AppThemes.blackmainTheme,
        appBar: AppBar(
          backgroundColor: Color(0xff0C0C0C),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            '${widget.name}',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                onbackpress();
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              margin: EdgeInsets.only(bottom: height / 15),
              padding: EdgeInsets.all(width / 30),
              child: _provider.loading == true
                  ? StreamBuilder(
                      stream: channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = jsonDecode(snapshot.data);
                          if (sms == '-1') {
                            sms = data['message'];
                            ApiUtilsClass.getStremSms(
                                _provider, data['message']);
                          } else if (sms != data['message']) {
                            ApiUtilsClass.getStremSms(
                                _provider, data['message']);
                            sms = data['message'];
                          }
                          print('responce sending is ${data['message']}');
                          print('message body = $data');
                        }
                        return ListView.builder(
                          itemBuilder: (c, i) {
                            return '${_provider.listmain[i]['user']}' !=
                                    '${ApiUtilsClass.userId}'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: width / 30,
                                      ),
                                      Text(
                                        '',
                                        style: TextStyle(
                                            color:
                                                AppThemes.blackTransparentTheme,
                                            fontSize: 13),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          _provider.loadingImage == true
                                              ? CircularProfileAvatar(
                                                  '${_provider.listuser['profile_picture']}',
                                                  borderColor: Colors.black,
                                                  elevation: 2,
                                                  radius: height / 30,
                                                )
                                              : CircularProfileAvatar(
                                                  '',
                                                  child: Container(
                                                    color: Colors.white,
                                                  ),
                                                  borderColor: Colors.black,
                                                  elevation: 2,
                                                  radius: height / 30,
                                                ),
                                          SizedBox(
                                            width: width / 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(width / 30),
                                            decoration: BoxDecoration(
                                                color: AppThemes.offBlackTheme
                                                    .withOpacity(0.7),
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: width / 1.9),
                                                child: Text(
                                                  '${_provider.listmain[i]['body']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )),
                                            margin: EdgeInsets.only(
                                                top: width / 30),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(width / 30),
                                        decoration: BoxDecoration(
                                            color: AppThemes.laightBlueTheme,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: width / 1.5),
                                            child: Text(
                                              '${_provider.listmain[i]['body']}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )),
                                        margin:
                                            EdgeInsets.only(top: width / 30),
                                      ),
                                    ],
                                  );
                          },
                          reverse: true,
                          itemCount: _provider.listmain == null
                              ? 0
                              : _provider.listmain.length,
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: width / 100, top: 2, bottom: 2),
                height: height / 11,
                width: width,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: width / 1.180,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(splashColor: Colors.transparent),
                        child: TextField(
                          autofocus: false,
                          controller: _provider.senderCon,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            border: InputBorder.none,
                            fillColor: AppThemes.offBlackTheme,
                            hintText: 'Text message',
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 14),
                            contentPadding: EdgeInsets.only(
                                left: 14.0, bottom: 4.0, top: 4.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppThemes.offBlackTheme),
                              borderRadius: BorderRadius.circular(23),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppThemes.offBlackTheme),
                              borderRadius: BorderRadius.circular(23),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.send,
                          color: AppThemes.offWhiteTheme,
                        ),
                        onPressed: () {
                          if (_provider.senderCon.text.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (_) => CupertinoAlertDialog(
                                      content: Center(
                                          child: Text('Please inter Text')),
                                    ));
                          } else {
                            ApiUtilsClass.addWebScocketSms(
                                _provider, "${widget.id}");
                            _provider.senderCon.clear();
                          }
                        })
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
