import 'package:get/get.dart';

import '../../data.network_caller/models/user_model.dart';
import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../../data.network_caller/utility/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _logInProgress = false;
  String _failureMessage = '';

  bool get logInProgress => _logInProgress;
  String get failureMessage => _failureMessage;

  Future<bool> login(String email, String password) async {
    _logInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller().postRequest(Urls.logInUrl,
        body: {"email": email, "password": password}, isLogin: true);
    _logInProgress = false;
    update();
    if (response.isSuccess) {
      await Get.find<AuthController>().saveUserInformation(
          response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      return true;
    } else {
      if (response.statusCode == 401) {
        _failureMessage = 'Your have given wrong email/password';
      } else {
        _failureMessage = 'log in failed! Please try again';
      }
    }
    return false;
  }
}
