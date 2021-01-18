import 'dart:io';
import 'package:SharingOut/Authentication/VerifyNumber.dart';
import 'package:SharingOut/WebScocket.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:SharingOut/Authentication/ChangePassword.dart';
import 'package:SharingOut/Authentication/EnterNumbertoVerify.dart';
import 'package:SharingOut/Authentication/LoginPage.dart';
import 'package:SharingOut/Authentication/SignUpSuccesPage.dart';
import 'package:SharingOut/GiverItemRequest.dart';
import 'package:SharingOut/GiverModeOrderPageHome.dart';
import 'package:SharingOut/HomePage.dart';
import 'package:SharingOut/ItemRequestedReciver.dart';
import 'package:SharingOut/LocalWidget/SnackBar.dart';
import 'package:SharingOut/ReciverOrderPageHome.dart';
import 'package:SharingOut/SharedPrefence/SharedPreference.dart';
import 'package:SharingOut/provider/BLockWebScocket.dart';
import 'package:SharingOut/provider/BlockAccount.dart';
import 'package:SharingOut/provider/BlockAddFood.dart';
import 'package:SharingOut/provider/BlockFoodUpdate.dart';
import 'package:SharingOut/provider/BlockGiverActiveRequest.dart';
import 'package:SharingOut/provider/BlockGiverItemRequested.dart';
import 'package:SharingOut/provider/BlockGiverMode.dart';
import 'package:SharingOut/provider/BlockHomePage.dart';
import 'package:SharingOut/provider/BlockItemRequestedReciver.dart';
import 'package:SharingOut/provider/BlockLogin.dart';
import 'package:SharingOut/provider/BlockNearbySearch.dart';
import 'package:SharingOut/provider/BlockOrderState.dart';
import 'package:SharingOut/provider/BlockReciverActiveRequest.dart';
import 'package:SharingOut/provider/BlockReciverOrderPageHome.dart';
import 'package:SharingOut/provider/BlockSignUp.dart';
import 'package:dio/dio.dart';
import 'package:SharingOut/provider/BlockUserDetail.dart';
import 'package:SharingOut/provider/BlockWeScocketHome.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApiUtilsClass {
  // final apiKey = a4vgeVD8.TzZTmmgpODvMslpXwMR163Njy92O52j2
  static String serverkey = 'Api-Key a4vgeVD8.TzZTmmgpODvMslpXwMR163Njy92O52j2';
  static String token = '';
  static String deviceId = '';
  static String firebaseToken = '';
  static final String baseUrl = 'http://app.sharingout.org:4990';
  static int userId;
  static String userName;
  static String userEmail;
  static String userPhone;
  static String userProfile;
  static final String wsbaseUrl = 'ws://app.sharingout.org:4990';
  static final String login = '/account/login/';
  static final String signUP = '/account/register/';
  static final String otpVerify = '/account/resend-otp/';
  static final String otpVerifyfinal = '/account/email-verify/';
  static final String resetRequest = '/account/request-reset-password/';
  static final String addfoodData = '/api/food/';
  static final String getfoodData = '/api/v2/food/';
  static final String updateFood = '/api/food/update/';
  static final String searchFood = '/api/v2/search/';
  static final String getAllSms = '/api/message/';
  static final String requestItemReciver = '/api/v2/order/receiver/completed';
  static final String activeRequestReciver = '/api/order/receiver/active';
  static final String requestItemGiver = '/api/v2/order/giver/completed';
  static final String activeRequestGiver = '/api/order/giver/active';
  static final String updateAccount = '/account/user/';

  static Future loginCalling({BlockLogin provider}) async {
    try {
      var response = await Dio().post('$baseUrl$login',
          data: {
            'email': '+92${provider.loginemailCon.text}',
            'password': '${provider.loginpasswordCon.text}',
            'device_id': '$deviceId',
            "device_type": "ios",
            'firebase_token': '$firebaseToken'
          },
          options: Options(
              headers: {'Authorization': serverkey},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('data is = $data');
      print('responce = ${response.statusCode}');
      if (response.statusCode == 200) {
        token = data['data']['access_token'];
        userId = data['data']['userid'];
        userName = data['data']['name'];
        userEmail = data['data']['email'];
        userPhone = "${data['data']['phone number']}";
        SharedPreferenceClass.addtoken(token);
        SharedPreferenceClass.adduserID(userId);
        SharedPreferenceClass.addmode('R');
        SharedPreferenceClass.adduserName(userName);
        SharedPreferenceClass.adduserEmail(userEmail);
        SharedPreferenceClass.adduserphone(userPhone);

        provider.setLoadiing(false);
        SnackBars.snackbar(
            c: Colors.green,
            key: provider.scaffoldKey,
            text: 'successfully login');
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
              provider.scaffoldKey.currentContext,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockHomePage(),
                    child: HomePage(
                      mode: 'G',
                    ),
                  )));
        });
      } else if (response.statusCode == 401) {
        provider.setLoadiing(false);
        SnackBars.snackbar(
            c: Colors.red, key: provider.scaffoldKey, text: '${data['error']}');
        Future.delayed(Duration(seconds: 2), () {
          if (data['error'] == 'Phone is not verified' || data['error'] == 'Email is not verified') {
            Navigator.push(provider.scaffoldKey.currentContext,
                MaterialPageRoute(builder: (c) => VerifyNumber(wich: 'login',)));
          }
        });
      } else {
        provider.setLoadiing(false);
        SnackBars.snackbar(
            c: Colors.red, key: provider.scaffoldKey, text: '$data');
      }
    } on DioError catch (e) {
      if (e is DioError) {
        //handle DioError here by error type or by error code

      } else {}
    }
  }

  static Future signCalling({BlockSignUp provider}) async {
    try {
      var response = await Dio().post('$baseUrl$signUP',
          data: {
            'name': '${provider.sigUserNameCon.text}',
            'email': '${provider.signemailCon.text}',
            'password': '${provider.signpasswordCon.text}',
            'phone_number': '+92${provider.signPhoneCon.text}',
          },
          options: Options(
              headers: {'Authorization': serverkey},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 201) {
        provider.setLoadiing(false);
        SnackBars.snackbar(
            c: Colors.green,
            key: provider.scaffoldKey,
            text:
                'User successfully created please verify your number to login');
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
              provider.scaffoldKey.currentContext,
              MaterialPageRoute(
                  builder: (c) => EnterNumbertoVerify(
                        email: provider.signemailCon.text,
                      )));
        });
      } else if (response.statusCode == 400) {
        provider.setLoadiing(false);
        SnackBars.snackbar(
            c: Colors.red, key: provider.scaffoldKey, text: '$data');
      } else {
        provider.setLoadiing(false);
        SnackBars.snackbar(
            c: Colors.red, key: provider.scaffoldKey, text: '$data');
      }
    } catch (e) {}
  }

  static Future otpVerification(
      String mail, GlobalKey<ScaffoldState> scaffoldKey, String wich) async {
    try {
      var response = await Dio().post(
        '$baseUrl$otpVerify',
        data: {
          'email': '$mail',
        },
        options: Options(headers: {'Authorization': serverkey}),
      );
      var data = response.data;

      if (response.statusCode == 200) {
        SnackBars.snackbar(
            c: Colors.green,
            key: scaffoldKey,
            text: 'We have resent you OTP to verify your email');
        if (wich != '') {
          Future.delayed(Duration(minutes: 1), () {
            Navigator.push(
                scaffoldKey.currentContext,
                MaterialPageRoute(
                    builder: (c) => EnterNumbertoVerify(
                          email: mail,
                        )));
          });
        }
      } else {
        SnackBars.snackbar(
            c: Colors.red, key: scaffoldKey, text: '${data['error']}');
      }
    } catch (e) {}
  }

  static Future otpVerificationFinal(
      String otp, GlobalKey<ScaffoldState> scaffoldKey, String password) async {
    try {
      var response = await Dio().patch('$baseUrl$otpVerifyfinal',
          data: {
            'otp': '$otp',
          },
          options: Options(
              headers: {'Authorization': serverkey},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      if (response.statusCode == 200) {
        if (password == 'ok') {
          Navigator.push(
              scaffoldKey.currentContext,
              MaterialPageRoute(
                  builder: (c) => ChangePassword(
                        otp: otp,
                      )));
        }
        if (password == 'login') {
          Navigator.push(scaffoldKey.currentContext,
              MaterialPageRoute(builder: (c) => LoginPage()));
        } else {
          Navigator.push(scaffoldKey.currentContext,
              MaterialPageRoute(builder: (c) => SignUpSucsessPage()));
        }
      } else {
        SnackBars.snackbar(
            c: Colors.red, key: scaffoldKey, text: 'Invalid Otp ');
      }
    } catch (e) {}
  }

  static Future requestEmailForResetPasswordFinal(
      String mail, GlobalKey<ScaffoldState> scaffoldKey, String wich) async {
    print('$mail');
    try {
      var response = await Dio().post('$baseUrl$resetRequest',
          data: {
            'email': '+92$mail',
          },
          options: Options(
              headers: {'Authorization': serverkey},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        SnackBars.snackbar(
            c: Colors.green,
            key: scaffoldKey,
            text: 'We have sent you OTP to verify your number');
        Future.delayed(Duration(seconds: 2), () {
          if (wich == 'forgot') {
            Navigator.push(scaffoldKey.currentContext,
                MaterialPageRoute(builder: (c) => ChangePassword()));
          } else {
            Navigator.push(
                scaffoldKey.currentContext,
                MaterialPageRoute(
                    builder: (c) => EnterNumbertoVerify(
                          email: mail,
                          password: 'ok',
                        )));
          }
        });
      } else {
        SnackBars.snackbar(
            c: Colors.red, key: scaffoldKey, text: '${data['error']}');
      }
    } catch (e) {}
  }

  static Future forgotPassword(
      String text, GlobalKey<ScaffoldState> scaffoldKey, String otp) async {
    try {
      var response =
          await Dio().patch('$baseUrl/account/password-reset-complete/',
              data: {"password": "$text", "otp": "$otp"},
              options: Options(
                  headers: {'Authorization': serverkey},
                  followRedirects: false,
                  validateStatus: (status) {
                    return status <= 500;
                  }));
      var data = response.data;

      if (response.statusCode == 200) {
        SnackBars.snackbar(
            c: Colors.green,
            key: scaffoldKey,
            text: 'Password Updated successfully');
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
              scaffoldKey.currentContext,
              PageTransition(
                  duration: Duration(milliseconds: 500),
                  type: PageTransitionType.rightToLeft,
                  child: ChangeNotifierProvider(
                    create: (_) => BlockLogin(),
                    child: LoginPage(),
                  )));
        });
      } else {
        SnackBars.snackbar(c: Colors.red, key: scaffoldKey, text: '$data');
      }
    } catch (e) {}
  }

  static Future addFoodData({BlockAddFood provider, LatLng latLng}) async {
    FormData formData = FormData.fromMap({
      "name": "${provider.nameCon.text}",
      "description": "${provider.disCon.text}",
      "number_of_serving": provider.servings,
      "views": 0,
      "active": provider.status,
      "image": await MultipartFile.fromFile(provider.imageFile.path,
          filename: basename(provider.imageFile.path)),
      "latitude": latLng.latitude,
      "longitude": latLng.longitude,
      "rating": 0,
      "start_time": '${provider.ustartTime} ${provider.startTime}',
      "end_time": '${provider.uendTime} ${provider.endTime}'
    });

    try {
      var response = await Dio().post('$baseUrl$addfoodData',
          data: formData,
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      if (response.statusCode == 200) {
        SnackBars.snackbar(
            c: Colors.green,
            key: provider.scaffoldKey,
            text: 'Food Added successfully');
        Future.delayed(Duration(seconds: 1), () {
          provider.setAddingFood(false);
          Navigator.of(provider.scaffoldKey.currentContext).pop();
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockHomePage(),
                  child: HomePage(
                    mode: 'G',
                  ),
                )),
            ModalRoute.withName('/'),
          );
        });
      } else {
        SnackBars.snackbar(
            c: Colors.red, key: provider.scaffoldKey, text: 'Opps !');
      }
    } catch (e) {}
  }

  static Future getNextHomePageData(
      {BlockHomePage provider,
      RefreshController inactiverefreshController}) async {
    try {
      var response = await Dio().get('${provider.nextPageURL}',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('Status home data is = ${response.statusCode}');
      List datalist = data['results'];
      print(' data List is = $datalist');
      if (response.statusCode == 200) {
        provider.setnextPageURL('${data['next'] ?? ''}');
        for (var i = 0; i < datalist.length; i++) {
          if (datalist[i]['active'] == true) {
            provider.setactiveMainLis(datalist[i]);
          } else {
            provider.setinActiveList(datalist[i]);
          }
        }
      }
      inactiverefreshController.loadComplete();
    } catch (e) {
      print('Exception is = ${e.toString()}');
    }
  }

  static Future getHomePageData({BlockHomePage provider}) async {
    try {
      var response = await Dio().get('$baseUrl$getfoodData',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('home data is = $data');
      List datalist = data['results'];
      if (response.statusCode == 200) {
        provider.setnextPageURL('${data['next'] ?? ''}');
        for (var i = 0; i < datalist.length; i++) {
          if (datalist[i]['active'] == true) {
            provider.setactiveMainLis(datalist[i]);
          } else {
            provider.setinActiveList(datalist[i]);
          }
        }
        provider.setloading(true);
      } else if (response.statusCode == 401) {
        Navigator.push(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockLogin(),
                  child: LoginPage(),
                )));
      } else {}
    } catch (e) {
      print('Exception is = ${e.toString()}');
    }
  }

  static Future updateFoodData(
      {BlockFoodUpDate provider, LatLng latLng, String id, String url}) async {
    FormData formData;
    if (provider.imageFile == null) {
      formData = FormData.fromMap({
        "name": "${provider.nameCon.text}",
        "description": "${provider.disCon.text}",
        "number_of_serving": provider.servings,
        "views": 0,
        "active": provider.status,
        "latitude": "${latLng.latitude}",
        "longitude": "${latLng.longitude}",
        "rating": 0,
        "start_time": '${provider.ustartTime} ${provider.startTime}',
        "end_time": '${provider.uendTime} ${provider.endTime}'
      });
    } else {
      formData = FormData.fromMap({
        "name": "${provider.nameCon.text}",
        "description": "${provider.disCon.text}",
        "number_of_serving": provider.servings,
        "views": 0,
        "active": provider.status,
        "image": await MultipartFile.fromFile(provider.imageFile.path,
            filename: basename(provider.imageFile.path)),
        "latitude": "${latLng.latitude}",
        "longitude": "${latLng.longitude}",
        "rating": 0,
        "start_time": '${provider.ustartTime} ${provider.startTime}',
        "end_time": '${provider.uendTime} ${provider.endTime}'
      });
    }

    try {
      var response = await Dio().put('$baseUrl$updateFood$id/',
          data: formData,
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      if (response.statusCode == 201) {
        SnackBars.snackbar(
            c: Colors.green,
            key: provider.scaffoldKey,
            text: 'Food Updated successfully');
        Future.delayed(Duration(seconds: 1), () {
          provider.setAddingFood(false);
          Navigator.of(provider.scaffoldKey.currentContext).pop();
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
            PageTransition(
                duration: Duration(milliseconds: 500),
                type: PageTransitionType.rightToLeft,
                child: ChangeNotifierProvider(
                  create: (_) => BlockHomePage(),
                  child: HomePage(
                    mode: 'G',
                  ),
                )),
            ModalRoute.withName('/'),
          );
        });
      } else {
        SnackBars.snackbar(
            c: Colors.red, key: provider.scaffoldKey, text: 'Opps !');
      }
    } catch (e) {}
  }

  static Future deleteFood(
      {BuildContext context, String id, String mode}) async {
    try {
      var response = await Dio().delete('$baseUrl$updateFood$id/',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 204) {
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              duration: Duration(milliseconds: 500),
              type: PageTransitionType.rightToLeft,
              child: ChangeNotifierProvider(
                create: (_) => BlockHomePage(),
                child: HomePage(
                  mode: 'G',
                ),
              )),
          ModalRoute.withName('/'),
        );
      }
    } catch (e) {}
  }

  static Future searchFoodCallings(
      LatLng latLng, BlockNearbySearch provider) async {
    try {
      var response = await Dio().post('$baseUrl$searchFood',
          data: {
            'kms': '${provider.km}',
            'latitude': '${(latLng.latitude).toString()}',
            'longitude': '${(latLng.longitude).toString()}'
          },
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('data is = $data');
      List listData = data['results'];
      provider.setnextPageURL(data['next'] ?? '');
      if (response.statusCode == 200) {
        if (data.length == 0) {
          provider.setloadingtext('No product ...');
        }
        provider.setSeachList(listData);
        provider.setloading(true);
        Future.delayed(Duration(milliseconds: 200), () {
          provider.setAnim(true);
        });
      }
    } catch (e) {}
  }

  static Future searchNextFoodCallings(LatLng latLng,
      BlockNearbySearch provider, RefreshController controller) async {
    try {
      var response = await Dio().post('${provider.nextPageURL}',
          data: {
            'kms': '${provider.km}',
            'latitude': '${(latLng.latitude).toString()}',
            'longitude': '${(latLng.longitude).toString()}'
          },
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      List listData = data['results'];
      provider.setnextPageURL(data['next'] ?? '');
      if (response.statusCode == 200) {
        if (listData.length == 0) {
          provider.setloadingtext('No product ...');
        }
        for (var data in listData) {
          provider.addlistData(data);
        }
      }
      controller.loadComplete();
    } catch (e) {}
  }

  static Future getListOfSms(BlockWebScocketHome provider, int page) async {
    try {
      var response = await Dio().get('$baseUrl/api/user/',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.setListMain(data);
        provider.setloading(true);
      }
    } catch (e) {}
  }

  static Future getWebScocketSms(BlockWebScocket provider, int id) async {
    try {
      var response = await Dio().get('$baseUrl/api/message/',
          queryParameters: {'target': id},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.setListMain(data['results']);
        provider.setloading(true);
      }
    } catch (e) {}
  }

  static Future addWebScocketSms(BlockWebScocket provider, String reci) async {
    try {
      await Dio().post('$baseUrl/api/message/',
          data: {"recipient": reci, "body": provider.senderCon.text},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      provider.setstreams(true);
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getStremSms(BlockWebScocket provider, String id) async {
    try {
      var response = await Dio().get('$baseUrl/api/message/$id/',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.addListListData(data);
        provider.setstreams(false);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getOrderDetailPage(
      BlockReciverOrderPageHome provider, String id) async {
    print('id is  that = $id ');
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/request',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('first order Data is = s${response.statusCode}');
      print('first order Data is = s$data');
      if (response.statusCode == 200) {
        provider.setListMain(data);
      } else {
        provider.setErrorText('${data['error']}');
        provider.setOk(true);
        provider.setloading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateOrderDetailPage(
      BlockReciverOrderPageHome provider, String id) async {
    try {
      var response = await Dio().get('$baseUrl/api/order/$id/state',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('updated data is = $data');
      if (response.statusCode == 200) {
        if (data['cancelled'] == true) {
          provider.setstatus(false);
          SharedPreferenceClass.addmode('R');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
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
          provider.setListofmainprogress(data);
          provider.setloading(true);
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future reciverLocationUpdate(LocationData latlng, String id) async {
    try {
      await Dio().post('$baseUrl/api/order/$id/location',
          data: {'lat': '${latlng.latitude}', 'long': '${latlng.longitude}'},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future itemRequestedReciverData(
      BlockItemRequestedReciver provider) async {
    try {
      var response = await Dio().get(
        '$baseUrl$requestItemReciver',
        options: Options(
            headers: {'Authorization': 'Bearer $token'},
            followRedirects: false,
            validateStatus: (status) {
              return status <= 500;
            }),
      );
      var data = response.data;
      print('data is = $data');
      if (response.statusCode == 200) {
        provider.setSeachList(data['results']);
        provider.setnextPageURL(data['next'] ?? '');
        provider.setloading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future itemRequestedNextPageReciverData(
      BlockItemRequestedReciver provider) async {
    try {
      var response = await Dio().get('${provider.nextPageURL}',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('next page data = $data');
      if (response.statusCode == 200) {
        provider.setnextPageURL(data['next'] ?? '');
        List list = data['results'];
        for (data in list) {
          provider.addlistData(data);
        }
      }
      provider.refreshController.loadComplete();
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future activeReciverRequestData(
      BlockReciverActiveRequest provider) async {
    try {
      var response = await Dio().get('$baseUrl$activeRequestReciver',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.setSeachList(data);
        provider.setloading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future itemRequestedNextPageGiverData(
      {BlockGiverItemRequested provider,
      RefreshController refreshController}) async {
    try {
      var response = await Dio().get('${provider.nextPageURL}',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      var data = response.data;
      print('active request = $data');
      if (response.statusCode == 200) {
        provider.setnextPageURL(data['next'] ?? '');
        List list = data['results'];
        for (data in list) {
          provider.addnextPageData(data);
        }
      }
      refreshController.loadComplete();
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future itemRequestedGiverData(BlockGiverItemRequested provider) async {
    try {
      var response = await Dio().get('$baseUrl$requestItemGiver',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      var data = response.data;
      print('active request = $data');
      if (response.statusCode == 200) {
        provider.setSeachList(data['results']);
        provider.setnextPageURL(data['next'] ?? '');
        provider.setloading(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future activeGiverRequestData(BlockGiverActiveRequest provider) async {
    try {
      var response = await Dio().get('$baseUrl$activeRequestGiver',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      print('data = $data');
      if (response.statusCode == 200) {
        provider.setSeachList(data);
        provider.setloading(true);
      }
    } catch (e) {
      print('Exception is ${e.toString()}');
    }
  }

  static Future orderSateData(BlockOrderState provider, String id) async {
    try {
      await Dio().get('$baseUrl/api/order/$id/state',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      // if (response.statusCode == 200) {
      //   provider.setListMain(data);
      //   provider.setloading(true);
      // }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future reciverReached(String id) async {
    try {
      await Dio().post('$baseUrl/api/order/$id/reached',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future reciverCancel(BuildContext context, String id) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/cancel',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 201) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deliveryAcceptedReciver(BuildContext context, String id) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/deliveryaccepted',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 201) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deliveryAcceptedGiver(BuildContext context, String id) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/delivered',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 201) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateReciverLocation(
      String id, LocationData currentLocation) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$userId/location',
          data: {
            "lat": currentLocation.latitude,
            "long": currentLocation.longitude
          },
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 201) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateOrderStaeForGiver({
    BlockGiverMode provider,
    String id,
  }) async {
    try {
      var response = await Dio().get('$baseUrl/api/order/$id/state',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        if (data['cancelled'] == true) {
          SharedPreferenceClass.addmode('G');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Navigator.pushAndRemoveUntil(
            provider.scaffoldKey.currentContext,
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
        } else if (data['delivery_accepted'] == true) {
          provider.setDelivered('Accepted');
        }
        {
          provider.setListofmainprogress(data);
          provider.setloading(true);
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future ricevrexceptRequest({
    BlockGiverMode provider,
    String id,
  }) async {
    try {
      await Dio().post('$baseUrl/api/order/$id/accept',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future deliverRecivetoGiver(BuildContext context, String id) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/delivered',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));

      if (response.statusCode == 201) {}
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future updateAccountCalling(BlockAccount provider, String mode) async {
    FormData formData;
    if (provider.imageFile != null) {
      formData = FormData.fromMap({
        "name": "${provider.name}",
        "statement": "${provider.statement}",
        "profile_picture": await MultipartFile.fromFile(provider.imageFile.path,
            filename: basename(provider.imageFile.path))
      });
    } else {
      formData = FormData.fromMap({
        "name": "${provider.name}",
        "statement": "${provider.statement}",
      });
    }
    try {
      var response = await Dio().put('$baseUrl$updateAccount',
          data: formData,
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        userName = data['name'];
        String userProfile = data['profile_picture'];
        userPhone = "${data['phone_number']}";
        SharedPreferenceClass.addimage(userProfile);
        SharedPreferenceClass.adduserName(userName);
        SharedPreferenceClass.adduserphone(userPhone);
        SharedPreferenceClass.addmode(mode);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getAccountDataforHome(BlockHomePage provider) async {
    try {
      var response = await Dio().get('$baseUrl$updateAccount',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        ApiUtilsClass.userProfile = data['profile_picture'];
        ApiUtilsClass.userId = data['id'];
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future getAccountData(BlockAccount provider, String mode) async {
    try {
      var response = await Dio().get('$baseUrl$updateAccount',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.setstatement('${data['statement']}');
        provider.setprofile('${data['profile_picture']}');
        List list = data['ratings'];
        provider.setrating(list[0]);
        provider.setreview(list[1]);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future giverDataCalling({id, BuildContext context, chat}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user_token');
    int userID = prefs.getInt('user_id');
    String email = prefs.getString('user_email');
    String name = prefs.getString('user_name');
    String phone = prefs.getString('user_phone');
    ApiUtilsClass.token = token;
    ApiUtilsClass.userId = userID;
    ApiUtilsClass.userName = name;
    ApiUtilsClass.userEmail = email;
    ApiUtilsClass.userPhone = phone;
    try {
      var response = await Dio().get('$baseUrl/api/order/$id/state',
          options: Options(
              headers: {
                'Authorization': 'Bearer ${prefs.getString('user_token')}'
              },
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        int giverid = data['giver_id'];
        if (giverid == userId) {
          if (data['cancelled'] == true || data['completed'] == true) {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child: ChangeNotifierProvider(
                      create: (_) => BlockGiverItemRequested(),
                      child: GiverItemRequest(
                        wich: 'ok',
                      ),
                    )));
          } else if (data['completed'] == true) {
          } else {
            print('object');
            if (chat == true) {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: ChangeNotifierProvider(
                        create: (_) => BlockWebScocket(),
                        child: WebScocket(
                          id: data['receiver_id'],
                          name: data['receiver_name'],
                          idss: data['receiver_id'],
                          notification: true,
                        ),
                      )));
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: ChangeNotifierProvider(
                        create: (_) => BlockGiverMode(),
                        child: GiverModeOrderPageHome(
                          list: data,
                        ),
                      )));
            }
          }
        } else {
          if (data['cancelled'] == true || data['completed'] == true) {
            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 500),
                    type: PageTransitionType.rightToLeft,
                    child: ChangeNotifierProvider(
                      create: (_) => BlockItemRequestedReciver(),
                      child: ItemRequestedReciver(
                        wich: 'ok',
                      ),
                    )));
          } else {
            if (chat == true) {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: ChangeNotifierProvider(
                        create: (_) => BlockWebScocket(),
                        child: WebScocket(
                          id: data['giver_id'],
                          name: data['giver_name'],
                          idss: data['giver_id'],
                          notification: true,
                        ),
                      )));
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.rightToLeft,
                      child: ChangeNotifierProvider(
                        create: (_) => BlockReciverOrderPageHome(),
                        child: ReciverOrderPageHome(
                          id: data['receiver_id'],
                          hselist: 'yes',
                          list: data,
                        ),
                      )));
            }
          }
        }
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future addNoOfViewa(String id) async {
    try {
      await Dio().post('$baseUrl/api/food/view/$id/',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future userDetailforChat(BlockWebScocket provider, String id) async {
    try {
      var response = await Dio().get('$baseUrl/account/profile/$id',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.setlistuser(data);
        provider.setloadingImage(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future userDetail(BLockUserDetail provider, String id) async {
    try {
      var response = await Dio().get('$baseUrl/account/profile/$id',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;

      if (response.statusCode == 200) {
        provider.setMainData(data);
        provider.setLoadiing(true);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future userState(BlockHomePage provider) async {
    try {
      var response = await Dio().get('$baseUrl/api/stat',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      var data = response.data;
      if (response.statusCode == 200) {
        provider.setStateData(data);
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future addGiverRating(
      BlockGiverItemRequested provider, int v, String id) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/giver/rate',
          data: {"value": '$v'},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      if (response.statusCode == 200) {
        SnackBars.snackbar(
            c: Colors.green,
            key: provider.scaffoldKey,
            text: 'Food rated successfully');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }

  static Future addReciverRating(
      BlockItemRequestedReciver provider, int v, String id) async {
    try {
      var response = await Dio().post('$baseUrl/api/order/$id/receiver/rate',
          data: {"value": '$v'},
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              followRedirects: false,
              validateStatus: (status) {
                return status <= 500;
              }));
      if (response.statusCode == 200) {
        SnackBars.snackbar(
            c: Colors.green,
            key: provider.scaffoldKey,
            text: 'Food rated successfully');
      }
    } catch (e) {
      print('${e.toString()}');
    }
  }
}
