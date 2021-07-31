import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    @required String key,
    @required dynamic value,
  }) async {
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return await sharedPreferences.setBool(key, value);
  }

  static getData({
    @required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({
    @required String key,
  }) {
    return sharedPreferences.remove(key);
  }
}
