import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/AppThemes/AppThemes.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/LocalWidget/ImageViewer.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:SharingOut/provider/BlockAccount.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.mode}) : super(key: key);
  final String mode;
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  String mode;
  List starList = [1, 2, 3, 4, 5];
  @override
  void initState() {
    final BlockAccount _provider =
        Provider.of<BlockAccount>(context, listen: false);
    mode = widget.mode;
    _provider.setName('${ApiUtilsClass.userName}', false);
    _provider.setemail('${ApiUtilsClass.userEmail}', false);
    _provider.setphone('${ApiUtilsClass.userPhone}', false);
    getApiData(_provider);
    super.initState();
  }

  getApiData(BlockAccount provider) async {
    await ApiUtilsClass.getAccountData(provider, mode);
  }

  @override
  Widget build(BuildContext context) {
    final BlockAccount _provider = Provider.of<BlockAccount>(
      context,
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Account',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              fontFamily: 'Comfortaa',
              color: AppThemes.balckOpacityThemes),
        ),
        leading: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: AppThemes.balckOpacityThemes,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: height,
        width: width,
        padding: EdgeInsets.only(left: width / 10, right: width / 10),
        child: Column(
          children: [
            SizedBox(
              height: height / 20,
            ),
            _provider.profile == ''
                ? CircularProfileAvatar(
                    '',
                    child: CupertinoActivityIndicator(),
                    elevation: 10,
                    radius: height / 15,
                  )
                : _provider.imageFile != null
                    ? CircularProfileAvatar(
                        '',
                        child: Image.file(
                          File(_provider.imageFile.path),
                          fit: BoxFit.cover,
                        ),
                        elevation: 10,
                        radius: height / 15,
                      )
                    : InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => ImageViewer(
                                    image: '${_provider.profile}',
                                  )));
                        },
                        child: CircularProfileAvatar(
                          '${_provider.profile}',
                          elevation: 10,
                          radius: height / 15,
                        ),
                      ),
            SizedBox(
              height: height / 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 30,
                ),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 10,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      displayBottomSheet(context, _provider);
                    })
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            InkWell(
              onTap: () {
                _provider.editCon.text = _provider.statement;
                openDailog(context, _provider, 'statement');
              },
              child: Text(
                '${_provider.statement}',
                style: TextStyle(
                    color: AppThemes.balckOpacityThemes,
                    letterSpacing: 0.4,
                    fontSize: 14,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: height / 60,
            ),
            Row(
              children: [
                Text(
                  'Rating : ',
                  style: TextStyle(
                      color: AppThemes.balckOpacityThemes,
                      fontSize: 12,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w400),
                ),
                Row(
                  children: starList.map((e) {
                    int index = starList.indexOf(e);
                    return Icon(
                      starList[index] <= _provider.rating
                          ? Icons.star
                          : Icons.star_border,
                      color: AppThemes.darkYeloow,
                      size: 15,
                    );
                  }).toList(),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(
              height: height / 60,
            ),
            Row(
              children: [
                Text(
                  'Reviews : ${_provider.review}',
                  style: TextStyle(
                      color: AppThemes.balckOpacityThemes,
                      fontSize: 12,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w400),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            SizedBox(
              height: height / 40,
            ),
            InkWell(
                onTap: () {
                  _provider.editCon.text = _provider.name;
                  openDailog(context, _provider, 'name');
                },
                child: textWidget(
                    firsttext: 'Full Name', secondtext: '${_provider.name}')),
            SizedBox(
              height: height / 40,
            ),
            textWidget(firsttext: 'Email', secondtext: '${_provider.email}'),
            SizedBox(
              height: height / 40,
            ),
            textWidget(firsttext: 'Number', secondtext: '${_provider.phone}'),
            SizedBox(
              height: height / 30,
            ),
            // //  textWidget(firsttext: 'Food you like', secondtext: ''),
            //   SizedBox(
            //     height: height / 40,
            //   ),
            textWidget(
                firsttext: 'User ID', secondtext: '${ApiUtilsClass.userId}'),
            SizedBox(
              height: height / 40,
            ),
            Row(
              children: [
                Text(
                  mode == 'G' ? 'Rescue Mode' : 'Share Mode',
                  style: TextStyle(
                      color: AppThemes.mainThemes,
                      fontSize: 14,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w700),
                ),
                Switch(
                  value: mode == 'R' ? true : false,
                  onChanged: (value) {
                    if (mode == 'R') {
                      setState(() {
                        mode = 'G';
                      });
                    } else {
                      setState(() {
                        mode = 'R';
                      });
                    }
                  },
                  activeTrackColor: Colors.black26,
                  activeColor: AppThemes.mainThemes,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SizedBox(
              height: height / 30,
            ),
            InkWell(
              onTap: () {
                print('$mode');
                SnackBars.snackbar(
                    c: Colors.green, key: key, text: 'Updated successfully');
                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                        duration: Duration(milliseconds: 500),
                        type: PageTransitionType.rightToLeft,
                        child: ChangeNotifierProvider(
                          create: (_) => BlockHomePage(),
                          child: HomePage(
                            mode: mode,
                          ),
                        )),
                    ModalRoute.withName('/'),
                  );
                });
                ApiUtilsClass.updateAccountCalling(_provider, mode);
              },
              child: Container(
                height: height / 18,
                width: width / 2,
                child: Center(
                  child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white, fontSize: 13, letterSpacing: 0.5),
                  ),
                ),
                decoration: BoxDecoration(
                    color: AppThemes.mainThemes,
                    borderRadius: BorderRadius.circular(7)),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  openDailog(BuildContext context, BlockAccount provider, String wich) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: height / 5,
              child: ListView(
                children: [
                  SizedBox(
                    height: height / 30,
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: width / 30, right: width / 30),
                    height: height / 15,
                    width: width,
                    decoration: BoxDecoration(
                        color: AppThemes.offGraycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      controller: provider.editCon,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          hintText: 'Note Title Here',
                          hintStyle: TextStyle(fontSize: 12),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(width / 30)),
                    ),
                  ),
                  SizedBox(
                    height: height / 30,
                  ),
                  InkWell(
                    onTap: () {
                      if (wich == 'name') {
                        provider.setName(provider.editCon.text, true);
                        Navigator.of(context).pop();
                      } else if (wich == 'email') {
                        provider.setemail(provider.editCon.text, true);
                        Navigator.of(context).pop();
                      } else if (wich == 'phone') {
                        provider.setphone(provider.editCon.text, true);
                        Navigator.of(context).pop();
                      } else if (wich == 'statement') {
                        provider.setstatement(provider.editCon.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      height: height / 22,
                      margin:
                          EdgeInsets.only(left: width / 4, right: width / 4),
                      child: Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                      decoration: BoxDecoration(
                          color: AppThemes.mainThemes,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void displayBottomSheet(BuildContext context, BlockAccount provider) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(width / 30),
            height: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            provider.onImageButtonPressed(ImageSource.camera,
                                context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 100),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/camera.png'),
                          ),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width / 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            provider.onImageButtonPressed(ImageSource.gallery,
                                context: context);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.all(width / 35),
                            height: height / 10,
                            width: width / 5,
                            child: Image.asset('assets/gallary.png'),
                          ),
                        ),
                        Text(
                          'Gallary',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Comfortaa',
                              letterSpacing: 0.3,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
        });
  }

  Widget textWidget({String firsttext, String secondtext}) {
    return Row(
      children: [
        Text(
          '$firsttext',
          style: TextStyle(
              color: AppThemes.balckOpacityThemes,
              fontSize: 12,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3,
              fontWeight: FontWeight.w400),
        ),
        Text(
          '$secondtext',
          style: TextStyle(
              color: AppThemes.mainThemes,
              fontSize: 12,
              fontFamily: 'Comfortaa',
              letterSpacing: 0.3,
              fontWeight: FontWeight.w400),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
