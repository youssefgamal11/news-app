import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  //define shared preferences
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolen(
      {@required String key, @required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static getBoolen({@required String key}) {
    return sharedPreferences.getBool(key);
  }




}
