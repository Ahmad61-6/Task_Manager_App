import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import 'network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
      });

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          jsonResponse: jsonDecode(response.body),
          statusCode: 200,
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
}
