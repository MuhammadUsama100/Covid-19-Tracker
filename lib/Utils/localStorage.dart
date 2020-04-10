import 'dart:convert';
import 'package:coronavirus/Models/tracker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final Storage _singleton = new Storage._internal();
  static SharedPreferences _sharedPreferences;
  factory Storage() {
    return _singleton;
  }
  static initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return true;
  }

  static setValue(String key, String value) {
    _sharedPreferences.setString(key, value);
  }

  static getValue(String key) {
    return _sharedPreferences.getString(key);
  }

  static setlocal(String key, List<String> val) {
    return _sharedPreferences.setStringList(key, val);
  }

  static getlocal(String key) {
    return _sharedPreferences.getStringList(key);
  }

  static parse(String local) {
    Track track =  new Track();
    bool flag = false;
    bool flag2 = false;
    for (int i = 0; i < local.length; i++) {
      if (flag == true && local[i] == " " || flag2) {
        track.time = local[i];
        flag2 = true;
        flag = false;
      } else if (local[i] == " " || flag) {
        track.lat = local[i];
        flag = true;
      } else {
        track.long = local[i];
      }
    }
    return track;
  }

  Storage._internal();
}
