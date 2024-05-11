import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/screens/sign_in_screen.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';

import '../contollers/password_verification_sharedpreference.dart';
import '../widgets/snack_massage.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
      TextEditingController();
  final TextEditingController _newPassword2TEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool resetPasswordInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Set Password",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Minimum length password 8 character with\n"
                      "letter and number combination",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _newPasswordTEController,
                      obscureText: true,
                      decoration: textFormFieldDecoration("New Password"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'This field is empty';
                        } else if (value!.length < 8) {
                          return 'Minimum Length password 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _newPassword2TEController,
                      obscureText: true,
                      decoration: textFormFieldDecoration("Confirm Password"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'This field is empty';
                        } else if (value!.length < 8) {
                          return 'Minimum Length password 8 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 38,
                      child: Visibility(
                        visible: resetPasswordInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            style: appButtonStyle(),
                            onPressed: () {
                              if (_newPasswordTEController.text.trim() !=
                                  _newPassword2TEController.text.trim()) {
                                if (mounted) {
                                  showSnackMessage(context,
                                      "Confirm password should be same!", true);
                                }
                              } else {
                                resetPassword();
                              }
                            },
                            child: const Text("Confirm")),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Have an account!",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInScreen()),
                                  (route) => false);
                            },
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.greenAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      String? emailAddress = await readUserData("EmailVerification");
      String? otp = await readUserData("PINVerification");
      resetPasswordInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final response =
          await NetworkCaller().postRequest(Urls.resetPassword, body: {
        "email": emailAddress,
        "OTP": otp,
        "password": _newPasswordTEController.text.trim()
      });
      if (response.isSuccess) {
        resetPasswordInProgress = false;
        if (mounted) {
          setState(() {});
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false);
        }
      }
    }
  }

  @override
  void dispose() {
    _newPasswordTEController.dispose();
    _newPassword2TEController.dispose();
    super.dispose();
  }
}
