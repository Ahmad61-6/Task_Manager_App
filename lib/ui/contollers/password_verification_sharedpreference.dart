import 'package:shared_preferences/shared_preferences.dart';

Future<void> writeEmailVerification(email) async {
  final response = await SharedPreferences.getInstance();
  await response.setString("EmailVerification", email);
}

Future<void> writePINVerification(otp) async {
  final response = await SharedPreferences.getInstance();
  await response.setString('PINVerification', otp);
}

Future<String?> readUserData(key) async {
  final response = await SharedPreferences.getInstance();
  String? myData = response.getString(key);
  return myData;
}
