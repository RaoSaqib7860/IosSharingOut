import 'package:flutter/material.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';

class GiverDataCalling extends StatefulWidget {
  GiverDataCalling({Key key, this.userId, this.chat}) : super(key: key);
  final userId;
  final chat;
  @override
  _GiverDataCallingState createState() => _GiverDataCallingState();
}

class _GiverDataCallingState extends State<GiverDataCalling> {
  @override
  void initState() {
    giverDataCalling();
    super.initState();
  }

  Future giverDataCalling() async {
    await ApiUtilsClass.giverDataCalling(
      id: widget.userId,
      context: context,
      chat: widget.chat,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
