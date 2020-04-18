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
    //print(local);
    List<String> list = local.split(" ");
    Track track = new Track();
    track.long = list[0];
    track.lat = list[1];
    track.time = list[2] + " " + list[3];
    track.altitute = list[4];
    return track;
  }

  Storage._internal();
}
