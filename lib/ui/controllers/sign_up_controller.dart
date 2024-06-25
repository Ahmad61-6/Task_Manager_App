import 'package:get/get.dart';

import '../../data.network_caller/network_caller.dart';
import '../../data.network_caller/network_response.dart';
import '../../data.network_caller/utility/urls.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  String _failureMessage = "";

  bool get signUpInProgress => _signUpInProgress;
  String get failureMessage => _failureMessage;

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobileNo, String password) async {
    _signUpInProgress = true;

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.registrationUrl, body: {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobileNo,
      "password": password,
      "photo": ""
    });
    _signUpInProgress = false;
    update();
    if (response.isSuccess) {
      _failureMessage = 'Account has been created! Please login.';
      return true;
    } else {
      _failureMessage = 'Account creation failed! Please try again.';
    }
    return false;
  }
}
