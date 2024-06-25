import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';

import '../ui/controllers/auth_controller.dart';
import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> getRequest(String url) async {
    try {
      log(url);
      final Response response = await get(Uri.parse(url), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });

      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        backToLogIn();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMsg: e.toString());
    }
  }

  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
        'token': AuthController.token.toString(),
      });

      log(response.statusCode.toString());
      log(response.headers.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          backToLogIn();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMsg: e.toString());
    }
  }

  Future<void> backToLogIn() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigationKey.currentContext!,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (route) => false);
  }
}
