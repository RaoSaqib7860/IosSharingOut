import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  static addtoken(
    String token,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_token', "$token");
  }

  static addmode(String mode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mode', "$mode");
  }

  static adduserID(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('user_id', id);
  }

  static adduserName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', '$name');
  }

  static adduserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', '$email');
  }

  static adduserphone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_phone', '$phone');
  }

  static addimage(String profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_profile', '$profile');
  }

  static addgiverActive(String profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('giver_active', '$profile');
  }

  static addgiverCompleted(String profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('giver_completed', '$profile');
  }

  static addreciverActive(String profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('reciver_active', '$profile');
  }

  static addreciverCompleted(String profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('reciver_Completed', '$profile');
  }

  static removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user_token");
    prefs.remove("mode");
    prefs.remove("user_id");
    prefs.remove("user_name");
    prefs.remove("user_email");
    prefs.remove("user_phone");
    prefs.remove("giver_active");
    prefs.remove("giver_completed");
    prefs.remove("reciver_active");
    prefs.remove("reciver_Completed");
  }
}
