import 'dart:convert';

import 'package:practice_backend/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static SharedPreferences? _prefs;

  setSharePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> clearAll() async {
    await _prefs?.clear();
    return true;
  }

  Future<bool> isLogin() async {
    return _prefs?.getBool("isLogin") ?? false;
  }

  Future<bool> setIsLogin(bool isLogin) async {
    return await _prefs?.setBool("isLogin", isLogin) ?? false;
  }

  Future<UserModel> getUser() async {
    String? userString = _prefs?.getString("user");
    if (userString == null) {
      return UserModel();
    } else {
      return UserModel.fromJson(json.decode(userString));
    }
  }

  Future<bool> setUser(UserModel user) async {
    String userString = json.encode(user.toJson());
    return await _prefs?.setString("user", userString) ?? false;
  }

  Future<String?> getToken() async {
    return _prefs?.getString("token");
  }

  Future<bool> setToken(String token) async {
    return await _prefs?.setString("token", token) ?? false;
  }
}
