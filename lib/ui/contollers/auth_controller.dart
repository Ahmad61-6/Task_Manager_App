import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data.network_caller/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? user;
  static ValueNotifier<String?> emailNotifier = ValueNotifier(null);
  static ValueNotifier<String?> firstNameNotifier = ValueNotifier(null);
  static ValueNotifier<String?> profilePhotoNotifier = ValueNotifier(null);

  static Future<void> saveUserInformation(String t, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', t);
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));

    token = t;
    user = model;
  }

  static Future<void> updateUserInformation(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(model.toJson()));

    user = model;
    emailNotifier.value = user?.email;
    firstNameNotifier.value = user?.firstName;
    profilePhotoNotifier.value = user?.photo;
  }

  static Future<void> initializeUserCache() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString('user') ?? '{}'));
    emailNotifier.value = user?.email;
    firstNameNotifier.value = user?.firstName;
  }

  static Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');

    if (token != null) {
      await initializeUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    token = null;
  }
}
