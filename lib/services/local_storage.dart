import 'dart:async';
import 'dart:convert';

import 'package:marika_client/services/entities/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef NewCallback = dynamic Function();
typedef FromJsonCallback = dynamic Function(Map<String, dynamic> json);

class LocalStorage {
  static LocalStorage _instance;
  LocalStorage._internal();

  factory LocalStorage() {
    if (_instance == null) {
      _instance = new LocalStorage._internal();
    }
    return _instance;
  }

  var infoMap = Map<String, dynamic>();

  Future<void> loadAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loadInfo<UserInfo>(prefs, ()=>UserInfo(), (map)=>UserInfo.fromJson(map));
  }

  Future<void> resetAllInfo() async {
    setInfo<UserInfo>(UserInfo(), hasSave: true);
  }

  T getInfo<T>() {
    return infoMap[T.toString()] as T;
  }

  Future<void> setInfo<T>(dynamic info, {bool hasSave = false}) async {
    infoMap[T.toString()] = info;
    if (hasSave) {
      String encoded = json.encode(info.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(T.toString(), encoded);
    }
  }

  // utility
  void _loadInfo<T>(SharedPreferences prefs, NewCallback newCB, FromJsonCallback fromJsonCB){
    String string = prefs.getString(T.toString());
    if (string != null) {
      dynamic decoded = json.decode(string);
      infoMap[T.toString()] = fromJsonCB(decoded);
    }
    else {
      infoMap[T.toString()] = newCB();
    }
  }
}
