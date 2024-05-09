import 'package:flutter/material.dart';
import 'package:task_manager_app/data.network_caller/models/user_model.dart';
import 'package:task_manager_app/data.network_caller/network_caller.dart';
import 'package:task_manager_app/data.network_caller/network_response.dart';
import 'package:task_manager_app/data.network_caller/utility/urls.dart';
import 'package:task_manager_app/style.dart';
import 'package:task_manager_app/ui/contollers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_bar.dart';
import 'package:task_manager_app/ui/screens/sign_up_screen.dart';
import 'package:task_manager_app/ui/widgets/body_background.dart';
import 'package:task_manager_app/ui/widgets/snack_massage.dart';

import 'forgot_password_email.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _logInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Get Started With",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTEController,
                      decoration: textFormFieldDecoration("Email"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: textFormFieldDecoration("Password"),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Please enter your password';
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
                        visible: _logInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            style: appButtonStyle(),
                            onPressed: login,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordEmailScreen()));
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.greenAccent),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _logInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller().postRequest(Urls.logInUrl,
        body: {
          "email": _emailTEController.text.trim(),
          "password": _passwordTEController.text
        },
        isLogin: true);
    _logInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainBottomNavBar()));
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Your have given wrong email/password');
        }
      } else {
        if (mounted) {
          showSnackMessage(context, 'log in failed! Please try again');
        }
      }
    }
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
