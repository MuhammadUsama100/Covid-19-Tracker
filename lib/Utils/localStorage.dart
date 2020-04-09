import 'dart:convert';
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

  Storage._internal();
}
